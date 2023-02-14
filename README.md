Midterm 100782088

Pond Rim Light with texture 
----------------------------
A new material was made that held both the rim light with bump mapping. The reason why this was done is because it allows
the water to be very noticeable with it bright blue waves. maxing out the bump and rim power makes it more eye catching. 
This was done by adding the properties, input, float and the rim dot product with saturate to make sure it shows on the edges. 


Ship rimlighting and hologram
-------------------------------
Having the rim light and hologram on the ship allow it to have better highlights reflecing in game.



ShipMove
------------------------
With the object having a rigidbody, I used the horizontal and vertical input instead of manually typing the code for the WASD. This 
was done because it was more time efficient and looked neater in code. The horizontal and vertical input were multiplied with the 
float speed relative to the objects XYZ coordinates. 

LUT change, color screen
-------------------------
A script was added to the camera allowing the LUT material to be drawn and displayed on the screen using the Grahpics.Blit,
making the materials an array. This allows me to add as much materials for our lut, the next step was to add the key input that toggled
off and on the lut changing. The LUT shader was using the excat texel for red blue and green and from there, we calculated the offset
for the x and y for when the LUT is imported it will be using that for precison. 

Resources 
3D Monkey - Blender
3D spaceship - https://www.cgtrader.com/free-3d-models/aircraft/jet/aircraft-stylized-lowpoly
water -https://3dtextures.me/2018/11/29/water-002/
ground - https://3dtextures.me/2022/05/21/stylized-stone-floor-005/