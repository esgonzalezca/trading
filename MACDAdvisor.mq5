//+------------------------------------------------------------------+
//|                                                  MACDAdvisor.mq5 |
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
bool buyMade=false;
void OnInit(){


}
void OnTick()
  {
//---
double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
  double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
  double Equity = AccountInfoDouble(ACCOUNT_EQUITY);
  double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
  
  double myPriceArrayMacd[];
  double myPriceArraySignal[];
  int MacdDefinition=iMACD(_Symbol,_Period,12,26,9,PRICE_CLOSE);
  //RSI
   double myRSIArray[];
   
   int myRSIDefinition =iRSI(_Symbol,_Period,14,PRICE_CLOSE);
   
   CopyBuffer(myRSIDefinition,0,0,3,myRSIArray);
   
   double myRSIValue=NormalizeDouble(myRSIArray[0],2);
   
   //MACD
  
  CopyBuffer(MacdDefinition,0,0,10,myPriceArrayMacd);
  CopyBuffer(MacdDefinition,1,0,10,myPriceArraySignal);
  
  float MacdValue= (myPriceArrayMacd[9]);
  float SignalValue=(myPriceArraySignal[9]);
  
  if(MacdValue<0 && SignalValue<0)
  buyMade=false;
  
  if(PositionsTotal()==0){
  if (buyMade== false && MacdValue>0 && SignalValue >0 && SignalValue<MacdValue && myPriceArrayMacd[8]>myPriceArrayMacd[7] && myPriceArraySignal[8]> myPriceArraySignal[7] && myRSIValue>70 ){
  trade.Buy(0.1, NULL, Ask, (Ask - 200 * _Point), (Ask + 100 * _Point), NULL);
  buyMade=true;
  
  }
  
  
  
  }
   
  }
//+------------------------------------------------------------------+
