unit unComPort;

interface

uses
    Windows, SysUtils;

type
    TComPortSpeed = (
        cps110    = CBR_110,
        cps300    = CBR_300,
        cps600    = CBR_600,
        cps1200   = CBR_1200,
        cps2400   = CBR_2400,
        cps4800   = CBR_4800,
        cps9600   = CBR_9600,
        cps14400  = CBR_14400,
        cps19200  = CBR_19200,
        cps38400  = CBR_38400,
        cps56000  = CBR_56000,
        cps576000 = CBR_57600,
        cps115200 = CBR_115200,
        cps128000 = CBR_128000,
        cps256000 = CBR_256000  );

    TComPortParity = (
        cppNo   = NOPARITY,
        cppOdd  = ODDPARITY,
        cppEven = EVENPARITY,
        cppMark = MARKPARITY  );

    TComPortStopBits = (
        cpsb1  = ONESTOPBIT,
        cpsb15 = ONE5STOPBITS,
        cpsb2  = TWOSTOPBITS  );

    TComPort = class
    private
        hCom        :Cardinal;
        bNumber     :byte;
        lSpeed      :TComPortSpeed;
        lBufIn      :Cardinal;
        lBufOut     :Cardinal;
        lByteSize   :Byte;
        lParity     :TComPortParity;
        lStopBits   :TComPortStopBits;
    public
        constructor Create();
        destructor  Destroy(); override;
        function    Open():boolean;       // открыть порт. если успешно, то возвращает true
        procedure   Close();              // закрыть порт
        function    Read(var buffer:string):Integer;    // прочитать данные в буфер. возвращает кол-во считанных байт или 0
        function    Write(const buffer:string):Integer; // записать данные из буфера. возвращает кол-во записанный байт или 0
        property    Number:byte read bNumber write bNumber;         // номер COM порта
        property    Speed:TComPortSpeed read lSpeed write lSpeed;   // скорость
        property    BufferIn:Cardinal read lBufIn write lBufIn;     // размер буфера чтения
        property    BufferOut:Cardinal read lBufOut write lBufOut;  // размер буфера записи
        property    ByteSize:Byte read lByteSize write lByteSize;   // кол-во бит
        property    Parity:TComPortParity read lParity write lParity;   // четность
        property    StopBits:TComPortStopBits read lStopBits write lStopBits;   // стоповые биты
    end;

//////////////////////////////////////
implementation
//////////////////////////////////////

{ TComPort }

constructor TComPort.Create;
begin
    inherited;
    hCom        := INVALID_HANDLE_VALUE;
    bNumber     := 1;
    lSpeed      := cps4800;
    lBufIn      := 1600;
    lBufOut     := 1600;
    lByteSize   := 8;
    lParity     := cppNo;
    lStopBits   := cpsb1;
end;

destructor TComPort.Destroy;
begin
    Close;
    inherited;
end;

procedure TComPort.Close;
begin
    if hCom<>INVALID_HANDLE_VALUE then begin
        CloseHandle(hCom);
        hCom := INVALID_HANDLE_VALUE;
    end;
end;

function TComPort.Open: boolean;
var s:string;
    dcb_: DCB;
begin
    result := false;
    Close();
    s := 'COM'+IntToStr(bNumber)+#0;
    hCom := CreateFile(PChar(s),GENERIC_READ or GENERIC_WRITE,0,nil,
                       OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if hCom=INVALID_HANDLE_VALUE then exit;
    SetupComm(hCom, lBufIn,lBufOut); //no need to check result. if failed, it uses default values.
    GetCommState(hCom,dcb_);
    {if not GetCommState(hCom,dcb_) then begin
        result := l_CE_GET_DCB;
        exit;
    end;}
    with dcb_ do begin
        DCBlength := SizeOf(dcb_);
        Flags := $00004001; //Binary or AbortOnErrors
        BaudRate := Ord(lSpeed);
        ByteSize := lByteSize;
        Parity := Ord(lParity);
        StopBits := Ord(lStopBits);
    end;
    if not SetCommState(hCom, dcb_) then begin
        Close();
        exit;
    end;
    result := true;
end;

function TComPort.Read(var buffer: string): Integer;
var errs,read_:Cardinal;
    cs:COMSTAT;
begin
    result := 0;
    buffer := '';
    if hCom=INVALID_HANDLE_VALUE then exit;
    errs := CE_BREAK or CE_FRAME or CE_OVERRUN or CE_RXPARITY;
    if not ClearCommError(hCom, errs, @cs) then exit;
    if cs.cbInQue>0 then begin
        SetLength(buffer,cs.cbInQue);
        if not ReadFile(hCom,buffer[1],cs.cbInQue, read_, nil) then begin
            buffer := '';
            exit;
        end;
        if (read_<cs.cbInQue) then begin //если прочиталось не все
            if (read_>0) then            //  если вообще что-то прочиталось
                Delete(buffer,read_+1, cs.cbInQue-read_) //  отрезаем лишнее
            else
                buffer:='';
        end;
    end;
    result := Length(buffer);
end;

function TComPort.Write(const buffer: string): Integer;
var errs,written:Cardinal;
    cs:COMSTAT;
begin
    result := 0;
    if hCom=INVALID_HANDLE_VALUE then exit;
    errs := CE_BREAK or CE_FRAME or CE_OVERRUN or CE_RXPARITY;
    if not ClearCommError(hCom, errs, @cs) then exit;
    if Length(buffer)>0 then begin
        if WriteFile(hCom, buffer[1], Length(buffer), written, nil) then
            result := written;
    end;
end;

end.
