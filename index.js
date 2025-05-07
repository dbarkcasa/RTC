function isStrongPassword(password) {
    // Check if the password is at least 8 characters
    if (password.length < 8) {
       return false;
    }
 
    // Check if it contains the word "password" (case insensitive)
    if (password.toLowerCase().includes("password")) {
       return false;
    }
 
    // Check if it has at least one uppercase character
    if (!/[A-Z]/.test(password)) {
       return false;
    }
 
    // Passed all checks
    return true;
 }
 
 console.log("Testing isStrongPassword()...");
 
 console.log("Qwerty - " + isStrongPassword("Qwerty"));                  // false - Too short
 console.log("passwordQwerty - " + isStrongPassword("passwordQwerty"));  // false - Contains "password"
 console.log("qwerty123 - " + isStrongPassword("qwerty123"));            // false - No uppercase chars
 console.log("Qwerty123 - " + isStrongPassword("Qwerty123"));            // true
 
 
 // Do NOT remove the following line:
 export default isStrongPassword; 