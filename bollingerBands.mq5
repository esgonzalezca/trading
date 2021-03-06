#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>

CTrade trade;

void OnTick()
  {
  
  double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
  double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
  double Equity = AccountInfoDouble(ACCOUNT_EQUITY);
  double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
  
   // bandas con 2 desviaciones
   double middleBandArray2[];
   double upperBandArray2[];
   double lowerBandArray2[];
   
   ArraySetAsSeries(middleBandArray2, true);
   ArraySetAsSeries(upperBandArray2, true);
   ArraySetAsSeries(lowerBandArray2, true);
   
   int bollingerBandsDefinition2 = iBands(_Symbol, _Period, 20, 0, 2, PRICE_CLOSE);
   
   CopyBuffer(bollingerBandsDefinition2, 0, 0, 3, middleBandArray2);
   CopyBuffer(bollingerBandsDefinition2, 1, 0, 3, upperBandArray2);
   CopyBuffer(bollingerBandsDefinition2, 2, 0, 3, lowerBandArray2);
   
   double myMiddleBandValue2 = middleBandArray2[0];
   double myUpperBandValue2 = upperBandArray2[0];
   double myLowerBandValue2 = lowerBandArray2[0];
           
   // bandas con 1 desviación
   double middleBandArray1[];
   double upperBandArray1[];
   double lowerBandArray1[];
   
   ArraySetAsSeries(middleBandArray1, true);
   ArraySetAsSeries(upperBandArray1, true);
   ArraySetAsSeries(lowerBandArray1, true);
   
   int bollingerBandsDefinition1 = iBands(_Symbol, _Period, 20, 0, 1, PRICE_CLOSE);
   
   CopyBuffer(bollingerBandsDefinition1, 0, 0, 3, middleBandArray1);
   CopyBuffer(bollingerBandsDefinition1, 1, 0, 3, upperBandArray1);
   CopyBuffer(bollingerBandsDefinition1, 2, 0, 3, lowerBandArray1);
   
   double myMiddleBandValue1 = middleBandArray1[0];
   double myUpperBandValue1 = upperBandArray1[0];
   double myLowerBandValue1 = lowerBandArray1[0];
     
   //Calcular los precios de cierre        
   MqlRates priceInformation[];
   
   ArraySetAsSeries(priceInformation, true);
   
   int data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), priceInformation);    
   
   double closePrice = priceInformation[0].close;
   
   Comment("\nClose price candle 0: ", closePrice, "\n",
           "myUpperBandValue1: ", myUpperBandValue1, "\n", 
           "myUpperBandValue2: ", myUpperBandValue2, "\n", 
           "myLowerBandValue1: ", myLowerBandValue1, "\n",
           "myLowerBandValue2: ", myLowerBandValue2, "\n");
   
   //Hacer operaciones de compra en el cuarto superior y venta en el cuarto inferior
   if(closePrice <= myUpperBandValue2 && closePrice >= myUpperBandValue1 && PositionsTotal() == 0)
      trade.Buy(0.1, NULL, Ask, (Ask - 200 * _Point), (Ask + 100 * _Point), NULL);
   
   //if(closePrice <= myLowerBandValue1 && closePrice >= myLowerBandValue2 && PositionsTotal() == 0)
      //trade.Sell(0.1, NULL, Bid, (Bid + 200 * _Point), (Bid - 150 * _Point), NULL);
  }         
