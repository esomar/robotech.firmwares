<?
//`echo f >>toradul`;
switch ($_POST['command']){
  case "forward": `echo f >>../toradul`;
                  break;
  case "back": `echo b >>../toradul`;
                  break;
  case "stop": `echo s >>../toradul`;
                  break;
  case "left": `echo l >>../toradul`;
                  break;
  case "right": `echo r >>../toradul`;
                  break;

};

//foreach ($_POST as $k => $v){
//exec ("echo >>./log $k $v");
//}
?>
