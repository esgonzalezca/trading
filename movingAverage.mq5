//+------------------------------------------------------------------+
//|                                                movingAverage.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
//+------------------------------------------------------------------+

CTrade trade;

void OnTick()
  {
  
  double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
  double Balance =AccountInfoDouble(ACCOUNT_BALANCE);
  double Equity = AccountInfoDouble(ACCOUNT_EQUITY);
  
  
//---
double myMovingAverageArray[];
 int movingDefinition= iMA (_Symbol,_Period,20,0,MODE_SMA,PRICE_CLOSE);
 
 ArraySetAsSeries(myMovingAverageArray,true);
 CopyBuffer(movingDefinition,0,0,3,myMovingAverageArray);
 double myMovingValue=myMovingAverageArray[0];
 
 Comment("MovingAverageValue: ", myMovingValue);
//////// 
 double myMovingAverageArray2[];
 
 int movingDefinition2= iMA (_Symbol,_Period,7,0,MODE_SMA,PRICE_CLOSE);
 
 ArraySetAsSeries(myMovingAverageArray2,true);
 CopyBuffer(movingDefinition2,0,0,3,myMovingAverageArray2);
 double myMovingValue2=myMovingAverageArray2[0];
 
 Comment("MovingAverageValue: ", myMovingValue2);
 
 if(myMovingValue>myMovingValue2 && PositionsTotal()==0 && myMovingAverageArray2[0]>myMovingAverageArray2[1]){
 
 trade.Buy(0.01,NULL,Ask,Ask-200*_Point,(Ask+100*_Point),NULL);
 
 }
 
 
   
  }
//+------------------------------------------------------------------+
