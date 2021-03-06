#property copyright "WeWant"
#property link "http://www.moneywang.com"


extern string s1 ="***************************";
extern string Suffix = "";
extern string Symbs = "GBPUSD|EURGBP|EURUSD";

extern string s2 ="***************************";
extern double Lot = 0.1;
extern double P = -50;
extern int Magic = 201605;
extern int Slippage = 10;

int   font_size = 10 , openTime = 0;
color text_color = Lime;
int TimePrev = 0;
string sym[3];


int OnInit()
{  
   
   sym[0]=StringSubstr(Symbs,0,6) + Suffix ;
   sym[1]=StringSubstr(Symbs,7,6) + Suffix;
   sym[2]=StringSubstr(Symbs,14,6) + Suffix;
   
   //TimePrev = Time[0];
   
   int li_0 = font_size + font_size / 2;
   ObjectCreate("++-", OBJ_LABEL, 0, 0, 0);
   ObjectSet("++-", OBJPROP_CORNER, 1);
   ObjectSet("++-", OBJPROP_XDISTANCE, 5);
   ObjectSet("++-", OBJPROP_YDISTANCE, li_0);
   li_0 += font_size * 2;
   ObjectCreate("--+", OBJ_LABEL, 0, 0, 0);
   ObjectSet("--+", OBJPROP_CORNER, 1);
   ObjectSet("--+", OBJPROP_XDISTANCE, 5);
   ObjectSet("--+", OBJPROP_YDISTANCE, li_0);
   li_0 += font_size * 2;
      
   return (0);
}


void OnDeinit(const int reason)
{

}
void OnTick()
{   
   
   int order,order70,order30;
   double Amount,Amount70,Amount30;
   
   for(int cpt=0;cpt<OrdersTotal();cpt++)
   {
      OrderSelect(cpt,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic)
      {
         order++;
         Amount += OrderProfit() + OrderSwap() + OrderCommission();
         if(OrderComment() == "++-" )
         {
            order70++;
            Amount70 += OrderProfit() + OrderSwap() + OrderCommission();
         }
         
         if(OrderComment() == "--+" )
         {
            order30++;
            Amount30 += OrderProfit() + OrderSwap() + OrderCommission();
         }
      }
   }
   
   if(order70 == 0 && order30 == 0)
   {
      OpenOrder("BUY", Lot, sym[0],"++-");
      OpenOrder("BUY", Lot, sym[1],"++-");
      OpenOrder("SELL", Lot, sym[2],"++-");
      
      OpenOrder("SELL", Lot, sym[0],"--+");
      OpenOrder("SELL", Lot, sym[1],"--+");
      OpenOrder("BUY", Lot, sym[2],"--+");
      return;
   }
   
   if((Amount70 <= P && Amount30 > 0) || Amount30>-1*P)
   {
      CloseOrder("--+");
      return;
   }else if((Amount30 <= P && Amount70 > 0) ||  Amount70>-1*P)
   {
      CloseOrder("++-");
      return;
   }
   //------------
   int n = order70/3;
   if(n > 0 && Amount70 <= (n+n*(n-1)/2)*P)
   {
      OpenOrder("BUY", Lot, sym[0],"++-");
      OpenOrder("BUY", Lot, sym[1],"++-");
      OpenOrder("SELL", Lot, sym[2],"++-");
      return;
   }
   
   n = order30/3;
   if(n > 0 && Amount30 <=  (n+n*(n-1)/2)*P)
   {
      OpenOrder("SELL", Lot, sym[0],"--+");
      OpenOrder("SELL", Lot, sym[1],"--+");
      OpenOrder("BUY", Lot, sym[2],"--+");
      return;
   }
   
   
   
   ObjectSetText("++-", StringConcatenate("++- ", DoubleToStr(Amount70, 2)), font_size, "Arial", text_color);
   ObjectSetText("--+", StringConcatenate("--+ ", DoubleToStr(Amount30, 2)), font_size, "Arial", text_color);  
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



