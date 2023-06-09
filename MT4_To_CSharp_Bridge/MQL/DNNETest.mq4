//+------------------------------------------------------------------+
//|                                                     DNNETest.mq4 |
//|                                Copyright 2023, Dennis Gundersen. |
//|          https://github.com/DennisGundersen/MT4_To_CSharp_Bridge |
//+------------------------------------------------------------------+

#property copyright "Copyright 2023, Dennis Gundersen AS"
#property link      "https://github.com/DennisGundersen/MT4_To_CSharp_Bridge"
#property version   "1.04"
#property strict

// Load managed dll from /Libraries/
// Additional dlls must be placed in instances installation folder
// Remember x86 only!
#import "MT4_To_CSharp_BridgeNE.dll"
   //by value
   int GimmeAnInt(int a);
   int GetIntSum(int a, int b);
   int GetSum(int a, double b);
   int GetSumDoubles(double a, double b);
   
   //by reference
   
   int GimmeAnIntRefDummy(int &a);
   int GimmeAnIntRef(int &a);
   int GetIntSumRef(int &a, int &b);
   int GetSumRef(int &a, double &b);
   int GetSumDoublesRef(double &a, double &b);
   
   //bool
   bool GetNot(bool a);
   
   //string 
   int GetStringLength(string a);
   int ConvertHexToInt(string a);
   
   //async
   int GetIntAsync(int a, int delay);
   
   //DI
   int DIStart();
   int DIStop();
   int DIScopeNew();
   int DITestTransient();
   int DITestScoped();
   int DITestSingleton();

   //int GetAnswerByValue(int a, double b, bool c);
   //int GetAnswerByValueEx(int a, double b, bool c, string d);
   //void GetAnswerByReference(int &a, double &b, bool &c, string &d);
   //string GetAnswerByJSONObject(int a, double b, bool c, string d);
#import

input int DIRepeat = 5; //number of repeats of DI service executions (scope is changing after every 2 runs) 
input bool testSimple = false; //run tests of simple primitives arguments
input bool testString = false; //run tests of strings arguments
input bool testAsync = false; //run tests of functions with async
input bool testDI = true; //run tests of DI (Dependency Injection)
input bool testDIDetailed = false; //display more detailed DI execution (show Starting function)

int delayS = 4;
int myInt =  2;
int myInt2 = 4;
double myDouble = 2.5000;
double myDouble2 = 3.600;
bool myBool = true;
bool myBool2 = false;
string myString = "My string";
string myStringHex = "FF";

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

int OnInit()
{

   int result;
   
   if(testSimple)
   {
      //By Value
      result = GimmeAnInt(myInt);
      PrintFormat("GimmeAnInt(%d) returned: %d", myInt, result);
      
      PrintFormat("Starting GetIntSum(%d, %d)", myInt, myInt2);
      result = GetIntSum(myInt, myInt2);
      PrintFormat("GetIntSum(%d, %d) returned: ", myInt, myInt2, result);
      
      PrintFormat("Starting GetSum(%d, %f)", myInt, myDouble);
      result = GetSum(myInt, myDouble);
      PrintFormat("GetSum(%d, %f) returned: %d", myInt, myDouble, result);
      
      PrintFormat("Starting GetSumDoubles(%f, %f)", myDouble, myDouble2);
      result = GetSumDoubles(myDouble2, myDouble);
      PrintFormat("GetSumDoubles(%f, %f) returned: %d", myDouble, myDouble2, result);
      
      
      //By reference
      result = GimmeAnIntRefDummy(myInt);
      PrintFormat("GimmeAnIntRefDummy(%d) returned: %d", myInt, result);
      
      PrintFormat("Starting GimmeAnIntRef(%d)", myInt);
      result = GimmeAnIntRef(myInt);
      PrintFormat("GimmeAnIntRef(%d) returned: %d", myInt, result);
      
      PrintFormat("Starting GetIntSumRef(%d, %d)", myInt, myInt2);
      result = GetIntSum(myInt, myInt2);
      PrintFormat("GetIntSumRef(%d, %d) returned: %d", myInt, myInt2, result);
      
      PrintFormat("Starting GetSumRef(%d, %f)", myInt, myDouble);
      result = GetSumRef(myInt, myDouble);
      PrintFormat("GetSumRef(%d, %f) returned: %d", myInt, myDouble, result);
      
      PrintFormat("Starting GetSumDoublesRef(%f, %f)", myDouble, myDouble2);
      result = GetSumDoublesRef(myDouble, myDouble2);
      PrintFormat("GetSumDoublesRef(%f, %f) returned: %d", myDouble, myDouble2, result);
      
      bool bresult;
      PrintFormat("Starting GetNot(%d)", myBool);
      bresult = GetNot(myBool);
      PrintFormat("GetNot(%d) returned: %d", myBool, bresult);
      PrintFormat("Starting GetNot(%d)", myBool2);
      bresult = GetNot(myBool2);
      PrintFormat("GetNot(%d) returned: %d", myBool2, bresult);
   }
   if(testString)
   {
      PrintFormat("Starting GetStringLength(%s)", myString);
      result = GetStringLength(myString);
      PrintFormat("GetStringLength(%s) returned: %d", myString, result);
      
      PrintFormat("Starting ConvertHexToInt(%s)", myString);
      result = ConvertHexToInt(myString);
      PrintFormat("ConvertHexToInt(%s) returned: %d", myString, result);
      
      PrintFormat("Starting ConvertHexToInt(%s)", myStringHex);
      result = ConvertHexToInt(myStringHex);
      PrintFormat("ConvertHexToInt(%s) returned: %d", myStringHex, result);
   }
      
   /* default not working
   PrintFormat("Starting GetIntAsync(%d, 'default delay')", myInt);
   result = GetIntAsync(myInt);
   PrintFormat("GetIntAsync(%d, 'default delay') returned: %d", myInt, result);
   */
   
   if(testAsync)
   {
      PrintFormat("Starting GetIntAsync(%d, %d)", myInt, delayS);
      result = GetIntAsync(myInt, delayS);
      PrintFormat("GetIntAsync(%d, %d) returned: %d", myInt, delayS, result);
      
      delayS += 5;
      PrintFormat("Starting GetIntAsync(%d, %d)", myInt, delayS);
      result = GetIntAsync(myInt, delayS);
      PrintFormat("GetIntAsync(%d, %d) returned: %d", myInt, delayS, result);
   }
   
   if(testDI)
   {
      //DI
      PrintFormat("Starting DIStart()");
      result = DIStart();
      PrintFormat("DIStart() returned: %d", result);
      
      for(int i = 1; i <= DIRepeat; ++i)
      {
   	   if(testDIDetailed) PrintFormat("#%d: Starting DITestTransient()", i);
   	   result = DITestTransient();
   	   PrintFormat("#%d: DITestTransient() returned: %d", i, result);
   
   	   if(testDIDetailed) PrintFormat("#%d: Starting DITestScoped()", i);
   	   result = DITestScoped();
   	   PrintFormat("#%d: DITestScoped() returned: %d", i, result);
   
   	   if(testDIDetailed) PrintFormat("#%d: Starting DITestSingleton()", i);
   	   result = DITestSingleton();
   	   PrintFormat("#%d: DITestSingleton() returned: %d", i, result);
   	   if(!(i&1))
   	   {
   	      if(testDIDetailed) PrintFormat("#%d: Starting DIScopeNew()", i);
   	      result = DIScopeNew();
   	      PrintFormat("#%d: New scope DIScopeNew() returned: %d (scope number)", i, result);
   	   }
      }
   
      PrintFormat("Starting DIStop()");
      result = DIStop();
      PrintFormat("DIStop() returned: %d", result);
   }
   
   return(INIT_SUCCEEDED);
}


//+------------------------------------------------------------------+
//| Tick received function                                           |
//+------------------------------------------------------------------+
void OnTick()
{
}



//+------------------------------------------------------------------+
//| EA closing function call                                         |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{

}