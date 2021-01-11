#include <Trade\Trade.mqh>



void OnTick()
  {
  CTrade trade;
  string signal = "";
   
  double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
  double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
  double Equity = AccountInfoDouble(ACCOUNT_EQUITY);
  double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
  
  double kArray[];
  double dArray[];
  
  ArraySetAsSeries(kArray, true);
  ArraySetAsSeries(dArray, true);
  
  int stochasticDefinition = iStochastic(_Symbol, _Period, 5, 3, 3, MODE_SMA, STO_LOWHIGH);
   
  CopyBuffer(stochasticDefinition, 0, 0, 3, kArray);
  CopyBuffer(stochasticDefinition, 1, 0, 3, dArray);
  
  double kValue0 = kArray[0];
  double dValue0 = dArray[0];
  
  double kValue1 = kArray[1];
  double dValue1 = dArray[1];
  
  if(kValue0 < 20 && dValue0 < 20)
   if((kValue0 > dValue0) && (kValue1 < dValue1))
      signal = "buy";
       
  if(kValue0 > 80 && dValue0 > 80)
   if((kValue0 < dValue0) && (kValue1 > dValue1))
      signal = "sell";
      
  if(signal == "sell" && PositionsTotal() < 1)
   trade.Sell(0.1, NULL, Bid, (Bid + 200 * _Point), (Bid - 150 * _Point), NULL);
   
  if(signal == "buy" && PositionsTotal() < 1)
   trade.Buy(0.1, NULL, Ask, (Ask - 200 * _Point), (Ask + 150 * _Point), NULL);
    
  Comment("The current signal is: ", signal);  
  }
