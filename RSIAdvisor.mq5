//+------------------------------------------------------------------+
//|                                                   RSIAdvisor.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
CTrade trade;

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
 double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
  double Bid=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   
   
   string signal="";
   
   double myRSIArray[];
   
   int myRSIDefinition =iRSI(_Symbol,_Period,14,PRICE_CLOSE);
   
   CopyBuffer(myRSIDefinition,0,0,3,myRSIArray);
   
   double myRSIValue=NormalizeDouble(myRSIArray[0],2);
   
   if(myRSIValue>70 && PositionsTotal()<1)
   trade.Buy(0.10,NULL,Ask,(Ask-200*_Point),(Ask+150*_Point),NULL);
      if(myRSIValue<30 && PositionsTotal()<1)
   
      trade.Sell(0.10,NULL,Bid,(Bid+200*_Point),(Bid-150*_Point),NULL);
  }
//+------------------------------------------------------------------+
