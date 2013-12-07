<?
switch ($_POST['command']){
  case "up": `echo v 20 >>../tocotton`;
                  break;
  case "down": `echo v 160 >>../tocotton`;
                  break;
  case "left": `echo h 160 >>../tocotton`;
                  break;
  case "right": `echo h 20 >>../tocotton`;
                  break;
  case "centerh": `echo h 90 >>../tocotton`;
                  break;
  case "centerv": `echo v 90 >>../tocotton`;
                  break;

};

?>
