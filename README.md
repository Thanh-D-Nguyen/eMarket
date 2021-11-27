# eMarket
## 1. Environment
 - MacOS Monterey 12.0.1
 - Xcode 13.1
 - Swift 5.5
 - CoreData
## 2. Architechture
 - VIPER
## 3. Application features
 - Store details & products screen:
     + Fetch the store detail and list of product to display on screen
     + Add to cart button on each product items
     + Show number of item in cart at cart icon (top right of screen)
     + Notice to user when product existed on cart
     + Retry when network not avaiable

 - Order summary screen:
    + Display the product(s) selected.
    + Display the total price.
    + Change delivery address
    + Add or subtract quantity of product
    + Delete button to immidiate delete product
    + Checkout to placement
 - Success screen:
    + Press Back to home button to back to home screen
    
## 4. Test
 - Project included Unit Test and UI Test
   + Test API (of 3)
   + Test Data on cart
   + Test Follow Order 1 Product (UI Test)
   + Test Follow Order 2 products and each product with quatity 2
