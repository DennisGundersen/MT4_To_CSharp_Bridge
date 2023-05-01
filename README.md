# Metatrader 4 to C# programming bridge using DNNE
A prototype / tutorial for connecting unmanaged code in MT4 (MQL) to managed code (C#) in modern .NET (6+) using DNNE. DNNE will in this project function a replacement for Robert Giesecke's UnmanagedExports, which is commonly used by MT4 developers, but which has not been updated to function past .NET Framework.

## Goal
The goal of this project is to create a simple reuseable C# dll can be loaded into MQL in order to extend MT4 functionality to take advantage of any .NET solution. No actual trading strategies will be included in this project, just a prototype showing how to do the "plumbing" in order to enable your own ideas using C# and modern .NET.

## About MT4
MetaTrader 4 is an electronic trading platform for foreign exchange traders by MetaQuotes. It has a simple built in programming IDE (MetaQuotes Language Editor, press F4) with is own language (MQL) which has a C++ like syntax. MQL allows traders to automate actions and strategies as well as connecting to external tools. MT4 is available for free from any number of Forex brokers, just open a demo account and download the client.

### Hints about programming in MT4
* You can program visual clues as "Indicators", or automate trading using "Expert Advisors" (EA). This project is an EA.
* To allow autotrading and usage of external code in MT4, go to Tools, Options, Expert Advisors and enable "Allow automated trading", "Allow DLL imports" and if calling web apis from MQL "Allow WebRequests for listed URL" (+ URL).
* MT4 only accepts "win-x86" runtime compilations (no "AnyCPU")
* An external file such as your C# library must be placed in the MT4 instance's "Data Folder"/MQL4/Libraries/ folder, while any additional files (external projects, NuGet packages etc.) must be placed in the MT4 instance's installation folder to be found.
* Your compiled code can now be run by dragging the file from the Navigator onto the active trading window.
* MQL uses the "Expert" window for logging, rather than the normal "Journal" window.
* MQL strings are unicode.
* MQL dates uses Unix time (1/1/1970).

## About DNNE
Dot Net Native Exports (DNNE) is an open source project being developed by Aaron Robinson ("a product owner" of .NET InterOp at Microsoft). 
Source code is available at https://github.com/AaronRobinsonMSFT/DNNE, and it's installable from NuGet.
* Note that DNNE must be set to "win-x86" in .csproj, along with some other properties referred to as DNNE.props in the guide.
* Due to DNNE using compiler settings, the project must be published to a folder, don't just take the files from the /bin directory.
* With current settings, DNNE is bundled with the library file and NE (for Native Exports) is added to the dll file name (so MT4_To_CSharp_BridgeNE.dll).