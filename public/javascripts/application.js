// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function textChange(elementID, defaultText)
{
   var element = document.getElementById(elementID);

   if(element.value == defaultText)
   {
      element.value = '';
   }
   else if(element.value == '')
   {
      element.value = defaultText;
   }
}