#property copyright "WeWant"
#property link "http://www.moneywang.com"


extern string s1 ="***************************";
extern string Suffix = "";
extern string Symbs = "EURUSD|GBPUSD";
extern string Rsi_sym = "EURGBP";
extern int Rsitf = 14;
extern int Rsi_UPPER = 70;
extern int Rsi_LOWER = 30;
extern double P = 100;



extern string s2 ="***************************";
extern double Lot = 1;
extern int Magic = 201603;
extern int Slippage = 0;





int   font_size = 10 , openTime = 0;
color text_color = Lime;
int TimePrev = 0;
string sym[2];
double price[6];
double minAmot;
double maxProfit;
double S1 = -250*Lot;
double S2 = -550*Lot;
double S3 = -1200*Lot;
double L1=3;
double L2=6;
double L3=9;


int OnInit()
{
   EventSetMillisecondTimer(0.2);
   
   //string Symcut=StringSubstr(Symbol(),0,6);
   sym[0]=StringSubstr(Symbs,0,6) + Suffix ;
   sym[1]=StringSubstr(Symbs,7,6) + Suffix;
   //sym[2]=StringSubstr(Symbs,14,6) + Suffix;
   
   //TimePrev = Time[0];
   
   int li_0 = font_size + font_size / 2;
   ObjectCreate("PROFIT", OBJ_LABEL, 0, 0, 0);
   ObjectSet("PROFIT", OBJPROP_CORNER, 1);
   ObjectSet("PROFIT", OBJPROP_XDISTANCE, 5);
   ObjectSet("PROFIT", OBJPROP_YDISTANCE, li_0);
   li_0 += font_size * 2;
   ObjectCreate("Equity", OBJ_LABEL, 0, 0, 0);
   ObjectSet("Equity", OBJPROP_CORNER, 1);
   ObjectSet("Equity", OBJPROP_XDISTANCE, 5);
   ObjectSet("Equity", OBJPROP_YDISTANCE, li_0);
   li_0 += font_size * 2;
   ObjectCreate("Rsi", OBJ_LABEL, 0, 0, 0);
   ObjectSet("Rsi", OBJPROP_CORNER, 1);
   ObjectSet("Rsi", OBJPROP_XDISTANCE, 5);
   ObjectSet("Rsi", OBJPROP_YDISTANCE, li_0);
   li_0 += font_size * 2;
      
   return (0);
}


void OnDeinit(const int reason)
{

}
void OnTick()
{
   double rsi_15 = iRSI(Rsi_sym+Suffix,PERIOD_M15,Rsitf,PRICE_CLOSE,0);
   
   
   
   int order,order70,order30;
   double Amount,Amount70,Amount30;
   
   for(int cpt=0;cpt<OrdersTotal();cpt++)
   {
      OrderSelect(cpt,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic)
      {
         order++;
         Amount += OrderProfit() + OrderSwap() + OrderCommission();
         if(OrderComment() == "70" )
         {
            order70++;
            Amount70 += OrderProfit() + OrderSwap() + OrderCommission();
         }
         
         if(OrderComment() == "30" )
         {
            order30++;
            Amount30 += OrderProfit() + OrderSwap() + OrderCommission();
         }
      }
   }
   
   if(rsi_15 > Rsi_UPPER && rsi_15 <99.9  && order70 == 0)
   {
      OpenOrder("SELL", Lot, sym[0],"70");
      OpenOrder("BUY", Lot, sym[1],"70");
      OpenOrder("BUY", Lot, Rsi_sym+Suffix ,"70");
   }
   
   if(rsi_15 < Rsi_LOWER && rsi_15 >0.1  && order30 == 0)
   {
      OpenOrder("BUY", Lot, sym[0],"30");
      OpenOrder("SELL", Lot, sym[1],"30");
      OpenOrder("SELL", Lot, Rsi_sym+Suffix ,"30");
   }
   
   double rsi_30 = iRSI(Rsi_sym+Suffix,PERIOD_M30,Rsitf,PRICE_CLOSE,0);
   double rsi_60 = iRSI(Rsi_sym+Suffix,PERIOD_H1,Rsitf,PRICE_CLOSE,0);
   double rsi_240 = iRSI(Rsi_sym+Suffix,PERIOD_H4,Rsitf,PRICE_CLOSE,0);
   
   //加仓
   if( (rsi_30 > 70 && Amount70<S1 && order70 == L1)  || 
       (rsi_60 > 72 && Amount70<S2&& order70 == L2)  || 
       (rsi_240 > 75 && Amount70<S3&& order70 == L3)  
   )
   {
      if (rsi_30 > 70 && Amount70<S1 && order70 == L1) 
      { 
         OpenOrder("SELL", 1.3*Lot, sym[0],"70");
         OpenOrder("BUY", 1.3*Lot, sym[1],"70");
         OpenOrder("BUY", 1.3*Lot, Rsi_sym+Suffix ,"70");
         
      }else if (rsi_60 > 72 && Amount70<S2&& order70 == L2)
      { 
         OpenOrder("SELL", 1.3*1.3*Lot, sym[0],"70");
         OpenOrder("BUY", 1.3*1.3*Lot, sym[1],"70");
         OpenOrder("BUY", 1.3*1.3*Lot, Rsi_sym+Suffix ,"70");
      }else if (rsi_240 > 75 && Amount70<S3&& order70 == L3)
      { 
         OpenOrder("SELL",1.3*1.3*1.3*Lot, sym[0],"70");
         OpenOrder("BUY", 1.3*1.3*1.3*Lot, sym[1],"70");
         OpenOrder("BUY", 1.3*1.3*1.3*Lot, Rsi_sym+Suffix ,"70");
      }
   }
   
   //加仓
   if( (rsi_30 < 30 && Amount30<S1&& order30 == L1)  || 
       (rsi_60 < 28 && Amount30<S2&& order30 == L2)  || 
       (rsi_240 < 25 && Amount30<S3&& order30 == L3) 
   )
   {
      if (rsi_30 < 30 && Amount30<S1&& order30 == L1){ 
         OpenOrder("BUY",  1.3*Lot, sym[0],"30");
         OpenOrder("SELL", 1.3*Lot, sym[1],"30");
         OpenOrder("SELL", 1.3*Lot, Rsi_sym+Suffix ,"30");
      }else if (rsi_60 < 28 && Amount30<S2&& order30 == L2){ 
         OpenOrder("BUY",  1.3*1.3*Lot, sym[0],"30");
         OpenOrder("SELL", 1.3*1.3*Lot, sym[1],"30");
         OpenOrder("SELL", 1.3*1.3*Lot, Rsi_sym+Suffix ,"30");
      }else if (rsi_240 < 25 && Amount30<S3&& order30 == L3){ 
         OpenOrder("BUY",  1.3*1.3*1.3*Lot, sym[0],"30");
         OpenOrder("SELL", 1.3*1.3*1.3*Lot, sym[1],"30");
         OpenOrder("SELL", 1.3*1.3*1.3*Lot, Rsi_sym+Suffix ,"30");
      }
   }
   
   if(Amount70 > P)
   {
      CloseOrder("70");
      return;
   }
   
   if(Amount30 > P)
   {
      CloseOrder("30");
      return;
   }
   
   ObjectSetText("PROFIT", StringConcatenate("PROFIT ", DoubleToStr(Amount, 2)), font_size, "Arial", text_color);
   ObjectSetText("Equity", StringConcatenate("Equity ", DoubleToStr(AccountEquity(), 2)), font_size, "Arial", text_color);
   ObjectSetText("Rsi", StringConcatenate("Rsi ", DoubleToStr(rsi_15, 5)), font_size, "Arial", text_color);   
}



void CloseOrder(string commt)
{
   double bid,ask;
   for (int i=OrdersTotal()-1; i>=0; i--)
   {
      if (OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
      {
         if (OrderMagicNumber() == Magic)
         {
            if (OrderType()==OP_BUY && OrderComment() == commt){
               bid = MarketInfo(OrderSymbol(),MODE_BID);
               OrderClose(OrderTicket(),OrderLots(),bid,Slippage,Blue);
            }
            if (OrderType()==OP_SELL && OrderComment() == commt){
               ask = MarketInfo(OrderSymbol(),MODE_ASK);
               OrderClose(OrderTicket(),OrderLots(),ask,Slippage,Red);
            }
         } 
      }
   }  
}



void OpenOrder(string ord,double LOT,string Sym,string commt)
{
   double SL,TP;
   int error;
   if (ord=="BUY"){
      
      error = OrderSend(Sym,OP_BUY,LOT,getPriceEach(Sym,MODE_ASK),Slippage,SL,TP,commt,Magic,0,Blue);
   }
   if (ord=="SELL"){
      error = OrderSend(Sym,OP_SELL,LOT,getPriceEach(Sym,MODE_BID),Slippage,SL,TP,commt,Magic,0,Red);
   }
   if (error==-1) 
   {  
     int err=GetLastError();
      Print("Error OPENORDER",err);
   }
}



double getPriceEach(string sym = "" , int MODE = 0)
{
   return MarketInfo(sym,MODE);
}



