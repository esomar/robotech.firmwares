<?php
$errno = 0;
$errstr = "";
$fp = fsockopen( '192.168.137.5', 8080, $errno, $errstr, 30 );
 
if( !$fp )
{
    echo "$errstr ($errno)<br />\n";
}
else
{
    fwrite( $fp, "GET /?action=stream&ignored.mjpeg HTTP/1.0\r\n\r\n" );
 
    while( $str = trim( fgets( $fp, 4096 ) ) )header( $str );
    fpassthru( $fp );
    fclose( $fp );
}
?>
