# Hcl_Task
Save Image and Data from Json Response and Fetch the same in Offline. The App Should Work in Online and Offline for both iPad and iPhone

Specifications Done:
1. Used third party JSON parser to parse the JSON data
2. Displayed Image, title, and description in table view
3. Title in the Navigation bar is updated from JSON
4. Each row are displayed according to contents available 
5. I am downloading the images using "SDwebImage"
6. The app will work offline also, I have used core data to save and fetch image and data
7. Refresh Control is used to refresh the table view
8. UI won't block when data is loaded
9. Support all iOS versions

Guidelines followed:

1.Used MVC Design pattern
2. I have not used a storyboard or xib. I have written everything programmatically
3. Scrolling is smooth as per scenarios (I used SDwebImage so image URL downloading is very smooth)
4. Supported for both iPhone and iPad in all orientations
5. Threading is used to update images
6. commented on the code where it is needed
7.  App functionalities are polished as much 
8. used cocoa pods when it is needed
