# CapstoneGroupCode
Holds the main MATLAB files for my work with a Mechanical Engineering capstone group in the Fall 2019 Semester

See <a href="https://gajjara.github.io/cleaning_device">my portfolio page</a> on this project.

README for TOI Retainer Data Set

Constants/Values
	delta z = 0.025 meters (or 50mm)
	pixels per cm = 560 pixels per cm
	pixel size = 1.785e-5 meters (or 17.85 microns)
	pixel dimensions (initial) = 4000 by 6000
	pixel dimensions (inputted) = 4000 by 4000
	exposure settings in camera same in all images
        	ND4 Filter used
		Shutter speed: 1/13
		ISO: 100
		Aperture: 5.6

	OR:
		No ND4 Filter
		Shutter Speed: 1/60
		IS0: 100
		Aperture: 5.6
	wavelength (estimated): 400nm

Imaging Procedure
	1. Place Camera 300mm away from Object
	2. Place Lens 10-20mm at light source
    	3. Estimate wavelength by using power meter to measure at what wavelength the power peaks from the light source 
	4. Place Retainer where transmitted light from the lens covers most of the 
	   retainer
    	5. Using camera and a caliper or ruler measure the pixel size of the camera
	6. Place focus marker at 250mm (50mm before object) and focus camera
	   to that spot, turn off lights, and take image
	7. Lights on, remove retainer, and place focus marker at 300mm (0mm at object) 
	   and focus camera to that spot, place retainer, turn off lights, and take image
	8. Lights on, remove retainer, and place focus marker at 350mm (50mm away object)
	   and focus camera to that spot, place retainer, turn off lights, and take image
	9. Repeat 4-6 until all samples taken.

Processing Algorithm
	Uses tie_my_v2.m function and poisson_solve.m function
	With main.m as the main function

	Note that:
	I1 or Img1 is the image focused before object
	I0 or Img0 is the image focused at the object
	I2 or Img2 is the image focused after  object
	These images have to be RGB images

Data Set
	First image in set is image focused before object
	Second image in set is image focused at object
	Third image in set is image focused behind object
	
Output images shown in OutputDataSet folder
Output values shown in OutputData.csv
