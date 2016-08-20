# toy_robot
Built in Ruby.

## Exercise ##
* Simulate a robot moving over a square tabletop (5,5) with an origin of SW(0,0). 
* Send commands to a simulation robot. Accepted commands include:
  * PLACE X, Y, F
    * PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST
    * The first valid command for a robot is PLACE. Ignore commands until a valid PLACE command is made.
    * PLACE commands can also be run after this initial command.
    * PLACE commands are ignored if they aren't within the bounds of the tabletop.
  * MOVE
    * MOVE will advance the toy robot one unit forward in the directon it is currently facing.
    * MOVE commands are ignored if they will result in the robot falling off the tabletop.
  * LEFT & RIGHT
    * LEFT and RIGHT will rotate the robot 90 degrees in the specified directon without changing the positon of the robot.
  * REPORT
    * REPORT will announce the X,Y and F of the robot to STDOUT.

