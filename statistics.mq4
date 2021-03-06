#property copyright "WeWant"
#property link "http://www.moneywang.com"
#property strict
#property indicator_chart_window

extern string  DisplayControl      = "Used to Adjust Overlay";

extern bool    displayOverlay      = true; // Turns the display on and off
extern bool    displayLogo         = true; // Turns off copyright and icon
extern int     displayXcord        = 10;  // Moves display left and right
extern int     displayTop        = 20;   // Moves display up and down
extern int     displayYcord        = 15;   // Moves display up and down
extern int     displayFontSize     = 9;    // Changes size of display characters
extern int     displaySpacing      = 14;   // Changes space between lines
extern color   displayColor        = DeepSkyBlue; // default color of display characters
extern int     corner = 0;

color c1 = Salmon,c2 = Lime;

void OnInit()
{  
   LabelCreate();
}

void OnDeinit(const int reason)
{
   Refresh();
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   if(rates_total<100)return 0;
   int cpt,optype,ordersBuy,ordersSell;
   double lastLot,orderPrice,buyProfit,buyTotalAmount,buyTotalLot,sellProfit,sellTotalAmount,sellTotalLot;
   color c = White;
   
   for(cpt=0;cpt<OrdersTotal();cpt++)
   {
      if(OrderSelect(cpt,SELECT_BY_POS,MODE_TRADES)  && OrderSymbol() == Symbol())
      {
         optype = OrderType();
         lastLot = OrderLots();
         orderPrice = NormalizeDouble(OrderOpenPrice(), Digits);
         if(optype == OP_BUY)
         {
            ordersBuy++;
            buyProfit += OrderProfit() + OrderSwap() + OrderCommission();
            buyTotalAmount += OrderOpenPrice() * OrderLots();
            buyTotalLot += OrderLots(); 
         }
         if(optype == OP_SELL)
         {
            ordersSell++;
            sellProfit += OrderProfit() + OrderSwap() + OrderCommission();
            sellTotalAmount += OrderOpenPrice() * OrderLots();
            sellTotalLot += OrderLots(); 
         }
      }
   }
   
   
   
   int timeStart0 = TimeCurrent() - TimeCurrent() % (60*60*24);
   int timeEnd0 = TimeCurrent();
   
   int timeStart1 = TimeCurrent() - TimeCurrent() % (60*60*24) - 60*60*24;
   int timeEnd1 = TimeCurrent() - TimeCurrent() % (60*60*24);
   
   int timeStart2 = TimeCurrent() - TimeCurrent() % (60*60*24) - 60*60*24*2;
   int timeEnd2 = TimeCurrent() - TimeCurrent() % (60*60*24) - 60*60*24;
   string datetime2 = StringSubstr(TimeToString(timeStart2),5,5);
   
   int timeStart3 = TimeCurrent() - TimeCurrent() % (60*60*24) - 60*60*24*3;
   int timeEnd3 = TimeCurrent() - TimeCurrent() % (60*60*24) - 60*60*24*2;
   string datetime3 = StringSubstr(TimeToString(timeStart3),5,5);
   
   
   int timeStart4 = TimeCurrent() - TimeCurrent() % (60*60*24) - 60*60*24*4;
   int timeEnd4 = TimeCurrent() - TimeCurrent() % (60*60*24) - 60*60*24*3;
   string datetime4 = StringSubstr(TimeToString(timeStart4),5,5);
   
   int timeStart5 = TimeCurrent() - TimeCurrent() % (60*60*24) - 60*60*24*5;
   int timeEnd5 = TimeCurrent() - TimeCurrent() % (60*60*24) - 60*60*24*4;
   string datetime5 = StringSubstr(TimeToString(timeStart5),5,5);
   
   
   int timeStartW = StrToTime(StringSubstr(TimeToString(TimeCurrent() - (DayOfWeek())*60*60*24),0,10));
   int timeEndW = TimeCurrent();
   
   
   int timeStartPW = StrToTime(StringSubstr(TimeToString(TimeCurrent() - (DayOfWeek()+7)*60*60*24),0,10));
   int timeEndPW = TimeCurrent() - DayOfWeek()*60*60*24;
   
   
   int timeStartM = StrToTime(StringSubstr(TimeToString(TimeCurrent()),0,7));
   int timeEndM = TimeCurrent();
   
   
   string timeStart_P_M_string = StringSubstr(TimeToString(TimeCurrent() - Day()*60*60*24-1),0,7);
   int timeStartPM = StrToTime(timeStart_P_M_string);
   int timeEndPM = StrToTime(StringConcatenate(Year(),".",Month(),".01"));
   
   int timeStartY = StrToTime(StringConcatenate(Year(),".01.01"));
   int timeEndY = TimeCurrent();
   
   
   double total0,total1,total2,total3,total4,total5,totalW,totalM,totalPW,totalPM,totalY;
   double lot0,lot1,lot2,lot3,lot4,lot5,lotW,lotM,lotPW,lotPM,lotY;
   double p0,p1,p2,p3,p4,pW,pM,pY;
   
   double deposit,profit,without;
   
   
   for(cpt=0;cpt<OrdersHistoryTotal();cpt++)
   {
      if(OrderSelect(cpt,SELECT_BY_POS,MODE_HISTORY))
      {
         if(OrderCloseTime() >= timeStart0 &&  OrderCloseTime() < timeEnd0 && (OrderType() == OP_BUY ||  OrderType() == OP_SELL))
         {
            lot0 += OrderLots();
            total0 += OrderProfit() + OrderCommission() + OrderSwap();
         }
         
         if(OrderCloseTime() >= timeStart1 &&  OrderCloseTime() < timeEnd1 && (OrderType() == OP_BUY ||  OrderType() == OP_SELL))
         {
            lot1 += OrderLots();
            total1 += OrderProfit() + OrderCommission() + OrderSwap();
         }
         if(OrderCloseTime() >= timeStart2 &&  OrderCloseTime() < timeEnd2 && (OrderType() == OP_BUY ||  OrderType() == OP_SELL))
         {
            lot2 += OrderLots();
            total2 += OrderProfit() + OrderCommission() + OrderSwap();
         }
         if(OrderCloseTime() >= timeStart3 &&  OrderCloseTime() < timeEnd3 && (OrderType() == OP_BUY ||  OrderType() == OP_SELL))
         {
            lot3 += OrderLots();
            total3 += OrderProfit() + OrderCommission() + OrderSwap();
         }
         if(OrderCloseTime() >= timeStart4 &&  OrderCloseTime() < timeEnd4 && (OrderType() == OP_BUY ||  OrderType() == OP_SELL))
         {
            lot4 += OrderLots();
            total4 += OrderProfit() + OrderCommission() + OrderSwap();
         }
         
         
         if(OrderCloseTime() >= timeStartW &&  OrderCloseTime() < timeEndW && (OrderType() == OP_BUY ||  OrderType() == OP_SELL))
         {
            lotW += OrderLots();
            totalW += OrderProfit() + OrderCommission() + OrderSwap();
         }
         
         if(OrderCloseTime() >= timeStartM &&  OrderCloseTime() < timeEndM && (OrderType() == OP_BUY ||  OrderType() == OP_SELL))
         {
            lotM += OrderLots();
            totalM += OrderProfit() + OrderCommission() + OrderSwap();
         }
         
         if(OrderCloseTime() >= timeStartPW &&  OrderCloseTime() < timeEndPW && (OrderType() == OP_BUY ||  OrderType() == OP_SELL))
         {
            lotPW += OrderLots();
            totalPW += OrderProfit() + OrderCommission() + OrderSwap();
         }
         
         if(OrderCloseTime() >= timeStartPM &&  OrderCloseTime() < timeEndPM && (OrderType() == OP_BUY ||  OrderType() == OP_SELL))
         {
            lotPM += OrderLots();
            totalPM += OrderProfit() + OrderCommission() + OrderSwap();
         }
         
         
         if(OrderCloseTime() >= timeStartY &&  OrderCloseTime() < timeEndY && (OrderType() == OP_BUY ||  OrderType() == OP_SELL))
         {
            lotY += OrderLots();
            totalY += OrderProfit() + OrderCommission() + OrderSwap();
         }
         
         
         
         if(OrderType() == OP_BUY ||  OrderType() == OP_SELL)
         {
            profit += OrderProfit() + OrderCommission() + OrderSwap();
         }
         
         if(OrderType() == 6 && OrderProfit() <0)
         {
            without += OrderProfit();
         }
         
         
      }
   }
   deposit = AccountBalance() - profit - without;
   if(AccountBalance() <= 0)
   {
      return 0;
   }
   
   if(displayLogo){
      ObjectSetText("ObjLabel1","2",36,"Wingdings",Crimson);
      ObjectSet("ObjLabel1",OBJPROP_CORNER,3);
      ObjectSet("ObjLabel1",OBJPROP_XDISTANCE,10);
      ObjectSet("ObjLabel1",OBJPROP_YDISTANCE,10);
   }
   
   ObjectSet("ObjBg",OBJPROP_CORNER,corner);
   ObjectSet("ObjBg",OBJPROP_XDISTANCE,displayXcord-7);
   ObjectSet("ObjBg",OBJPROP_YDISTANCE,displayTop + displayYcord-10);
   ObjectSet("ObjBg",OBJPROP_XSIZE,260);
   ObjectSet("ObjBg",OBJPROP_YSIZE,340);
   ObjectSet("ObjBg",OBJPROP_BGCOLOR,Gray); 
   ObjectSet("ObjBg",OBJPROP_ZORDER,0); 
      
   
   if(!displayLogo)ObjectDelete("ObjLabel1");  
   
   int li_0 = displayTop + displayYcord ;
   
   ObjectSetText("ObjLabel2",StringConcatenate("Current Time:  ", TimeToStr(TimeCurrent(), TIME_SECONDS)),displayFontSize,"Arial Bold",Lime);
   ObjectSet("ObjLabel2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel2",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel2",OBJPROP_YDISTANCE,li_0);
   
   li_0 += displayYcord ;
   ObjectSetText("ObjLabel3",StringConcatenate("Account:  ", IntegerToString(AccountNumber())),displayFontSize,"Arial Bold",Lime);
   ObjectSet("ObjLabel3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel3",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel3",OBJPROP_YDISTANCE,li_0);
   
   li_0 += displayYcord ;
   ObjectSetText("ObjLabel4","=================================",displayFontSize,"Arial Bold",White);
   ObjectSet("ObjLabel4",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel4",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel4",OBJPROP_YDISTANCE,li_0);
   
   li_0 += displayYcord +5;
   ObjectSetText("ObjLabel5","            Lots traded  Profit           Profitability",displayFontSize,"Arial Bold",displayColor);
   ObjectSet("ObjLabel5",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel5",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel5",OBJPROP_YDISTANCE,li_0);
   
   li_0 += displayYcord ;
   ObjectSetText("ObjLabel6","---------------------------------------------------------",displayFontSize,"Arial Bold",White);
   ObjectSet("ObjLabel6",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel6",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel6",OBJPROP_YDISTANCE,(li_0));
   
   li_0 += displayYcord ;
   if(total0/deposit > 0)
   {
      c = c1;
   }else{
      c =c2;
   }
   ObjectSetText("ObjLabel7","Today",displayFontSize,"Arial Bold",Aqua);
   ObjectSet("ObjLabel7",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel7",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel7",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel7-1",DoubleToStr(lot0,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel7-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel7-1",OBJPROP_XDISTANCE,(displayXcord+60));
   ObjectSet("ObjLabel7-1",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel7-2",DoubleToStr(total0,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel7-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel7-2",OBJPROP_XDISTANCE,(displayXcord+110));
   ObjectSet("ObjLabel7-2",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel7-3",StringConcatenate(DoubleToStr(total0/deposit*100,2),"%"),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel7-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel7-3",OBJPROP_XDISTANCE,(displayXcord+186));
   ObjectSet("ObjLabel7-3",OBJPROP_YDISTANCE,(li_0));
   
   
   
   li_0 += displayYcord ;
   if(total1/deposit >= 0)
   {
      c = c1;
   }else{
      c =c2;
   }
   ObjectSetText("ObjLabel8","Yesterday",displayFontSize,"Arial Bold",Aqua);
   ObjectSet("ObjLabel8",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel8",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel8",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel8-1",DoubleToString(lot1,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel8-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel8-1",OBJPROP_XDISTANCE,(displayXcord+60));
   ObjectSet("ObjLabel8-1",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel8-2",DoubleToString(total1,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel8-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel8-2",OBJPROP_XDISTANCE,(displayXcord+110));
   ObjectSet("ObjLabel8-2",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel8-3",StringConcatenate(DoubleToStr(total1/deposit*100,2),"%"),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel8-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel8-3",OBJPROP_XDISTANCE,(displayXcord+186));
   ObjectSet("ObjLabel8-3",OBJPROP_YDISTANCE,(li_0));
   
   li_0 += displayYcord ;
   if(total2/deposit >= 0)
   {
      c = c1;
   }else{
      c =c2;
   }
   ObjectSetText("ObjLabel9",StringConcatenate(datetime2,""),displayFontSize,"Arial Bold",Aqua);
   ObjectSet("ObjLabel9",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel9",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel9",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel9-1",DoubleToString(lot2,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel9-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel9-1",OBJPROP_XDISTANCE,(displayXcord+60));
   ObjectSet("ObjLabel9-1",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel9-2",DoubleToString(total2,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel9-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel9-2",OBJPROP_XDISTANCE,(displayXcord+110));
   ObjectSet("ObjLabel9-2",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel9-3",StringConcatenate(DoubleToStr(total2/deposit*100,2),"%"),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel9-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel9-3",OBJPROP_XDISTANCE,(displayXcord+186));
   ObjectSet("ObjLabel9-3",OBJPROP_YDISTANCE,(li_0));
   
   
   li_0 += displayYcord ;
   if(total3/deposit >= 0)
   {
      c = c1;
   }else{
      c =c2;
   }
   ObjectSetText("ObjLabel10",StringConcatenate(datetime3,""),displayFontSize,"Arial Bold",Aqua);
   ObjectSet("ObjLabel10",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel10",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel10",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel10-1",DoubleToString(lot3,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel10-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel10-1",OBJPROP_XDISTANCE,(displayXcord+60));
   ObjectSet("ObjLabel10-1",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel10-2",DoubleToString(total3,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel10-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel10-2",OBJPROP_XDISTANCE,(displayXcord+110));
   ObjectSet("ObjLabel10-2",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel10-3",StringConcatenate(DoubleToStr(total3/deposit*100,2),"%"),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel10-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel10-3",OBJPROP_XDISTANCE,(displayXcord+186));
   ObjectSet("ObjLabel10-3",OBJPROP_YDISTANCE,(li_0));
   
   
   li_0 += displayYcord ;
   if(total4/deposit >= 0)
   {
      c = c1;
   }else{
      c =c2;
   }
   ObjectSetText("ObjLabel11",StringConcatenate(datetime4,""),displayFontSize,"Arial Bold",Aqua);
   ObjectSet("ObjLabel11",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel11",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel11",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel11-1",DoubleToString(lot4,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel11-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel11-1",OBJPROP_XDISTANCE,(displayXcord+60));
   ObjectSet("ObjLabel11-1",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel11-2",DoubleToString(total4,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel11-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel11-2",OBJPROP_XDISTANCE,(displayXcord+110));
   ObjectSet("ObjLabel11-2",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel11-3",StringConcatenate(DoubleToStr(total4/deposit*100,2),"%"),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel11-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel11-3",OBJPROP_XDISTANCE,(displayXcord+186));
   ObjectSet("ObjLabel11-3",OBJPROP_YDISTANCE,(li_0));
   
   
   
   
   li_0 += displayYcord ;
   if(totalW/deposit >= 0)
   {
      c = c1;
   }else{
      c =c2;
   }
   ObjectSetText("ObjLabel12","Week",displayFontSize,"Arial Bold",Aqua);
   ObjectSet("ObjLabel12",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel12",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel12",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel12-1",DoubleToString(lotW,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel12-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel12-1",OBJPROP_XDISTANCE,(displayXcord+60));
   ObjectSet("ObjLabel12-1",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel12-2",DoubleToString(totalW,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel12-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel12-2",OBJPROP_XDISTANCE,(displayXcord+110));
   ObjectSet("ObjLabel12-2",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel12-3",StringConcatenate(DoubleToStr(totalW/deposit*100,2),"%"),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel12-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel12-3",OBJPROP_XDISTANCE,(displayXcord+186));
   ObjectSet("ObjLabel12-3",OBJPROP_YDISTANCE,(li_0));
   
   
   //Last week
   li_0 += displayYcord ;
   if(totalPW/deposit >= 0)
   {
      c = c1;
   }else{
      c =c2;
   }
   ObjectSetText("ObjLabelpw","Last week",displayFontSize,"Arial Bold",Aqua);
   ObjectSet("ObjLabelpw",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabelpw",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabelpw",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabelpw-1",DoubleToString(lotPW,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabelpw-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabelpw-1",OBJPROP_XDISTANCE,(displayXcord+60));
   ObjectSet("ObjLabelpw-1",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabelpw-2",DoubleToString(totalPW,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabelpw-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabelpw-2",OBJPROP_XDISTANCE,(displayXcord+110));
   ObjectSet("ObjLabelpw-2",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabelpw-3",StringConcatenate(DoubleToStr(totalPW/deposit*100,2),"%"),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabelpw-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabelpw-3",OBJPROP_XDISTANCE,(displayXcord+186));
   ObjectSet("ObjLabelpw-3",OBJPROP_YDISTANCE,(li_0));
   
   
   li_0 += displayYcord ;
   if(totalM/deposit >= 0)
   {
      c = c1;
   }else{
      c =c2;
   }
   ObjectSetText("ObjLabel13","Month",displayFontSize,"Arial Bold",Aqua);
   ObjectSet("ObjLabel13",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel13",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel13",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel13-1",DoubleToString(lotM,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel13-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel13-1",OBJPROP_XDISTANCE,(displayXcord+60));
   ObjectSet("ObjLabel13-1",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel13-2",DoubleToString(totalM,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel13-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel13-2",OBJPROP_XDISTANCE,(displayXcord+110));
   ObjectSet("ObjLabel13-2",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel13-3",StringConcatenate(DoubleToStr(totalM/deposit*100,2),"%"),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel13-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel13-3",OBJPROP_XDISTANCE,(displayXcord+186));
   ObjectSet("ObjLabel13-3",OBJPROP_YDISTANCE,(li_0));
   
   
   //last month
   li_0 += displayYcord ;
   if(totalPM/deposit >= 0)
   {
      c = c1;
   }else{
      c =c2;
   }
   ObjectSetText("ObjLabelpm",timeStart_P_M_string,displayFontSize,"Arial Bold",Aqua);
   ObjectSet("ObjLabelpm",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabelpm",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabelpm",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabelpm-1",DoubleToString(lotPM,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabelpm-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabelpm-1",OBJPROP_XDISTANCE,(displayXcord+60));
   ObjectSet("ObjLabelpm-1",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabelpm-2",DoubleToString(totalPM,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabelpm-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabelpm-2",OBJPROP_XDISTANCE,(displayXcord+110));
   ObjectSet("ObjLabelpm-2",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabelpm-3",StringConcatenate(DoubleToStr(totalPM/deposit*100,2),"%"),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabelpm-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabelpm-3",OBJPROP_XDISTANCE,(displayXcord+186));
   ObjectSet("ObjLabelpm-3",OBJPROP_YDISTANCE,(li_0));
   
   
   
   
   li_0 += displayYcord ;
   if(totalY/deposit >= 0)
   {
      c = c1;
   }else{
      c =c2;
   }
   ObjectSetText("ObjLabel14","Year",displayFontSize,"Arial Bold",Aqua);
   ObjectSet("ObjLabel14",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel14",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel14",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel14-1",DoubleToString(lotY,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel14-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel14-1",OBJPROP_XDISTANCE,(displayXcord+60));
   ObjectSet("ObjLabel14-1",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel14-2",DoubleToString(totalY,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel14-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel14-2",OBJPROP_XDISTANCE,(displayXcord+110));
   ObjectSet("ObjLabel14-2",OBJPROP_YDISTANCE,(li_0));
   
   ObjectSetText("ObjLabel14-3",StringConcatenate(DoubleToStr(totalY/deposit*100,2),"%"),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel14-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel14-3",OBJPROP_XDISTANCE,(displayXcord+186));
   ObjectSet("ObjLabel14-3",OBJPROP_YDISTANCE,(li_0));
   
   
   li_0 += displayYcord ;
   ObjectSetText("ObjLabel15","=================================",displayFontSize,"Arial Bold",White);
   ObjectSet("ObjLabel15",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel15",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel15",OBJPROP_YDISTANCE,li_0);
   
   li_0 += displayYcord ;
   ObjectSetText("ObjLabel16","        Number   Lots      Prifit           Capacity",displayFontSize,"Arial Bold",displayColor);
   ObjectSet("ObjLabel16",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel16",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel16",OBJPROP_YDISTANCE,li_0);
   
   li_0 += displayYcord ;
   if(buyProfit >= 0)
   {
      c = c1;
   }else{
      c = c2;
   }
   ObjectSetText("ObjLabel17","Buy",displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel17",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel17",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel17",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel17-1",IntegerToString(ordersBuy),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel17-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel17-1",OBJPROP_XDISTANCE,(displayXcord+40));
   ObjectSet("ObjLabel17-1",OBJPROP_YDISTANCE,li_0);

   ObjectSetText("ObjLabel17-2",DoubleToString(buyTotalLot,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel17-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel17-2",OBJPROP_XDISTANCE,(displayXcord+80));
   ObjectSet("ObjLabel17-2",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel17-3",DoubleToString(buyProfit,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel17-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel17-3",OBJPROP_XDISTANCE,(displayXcord+120));
   ObjectSet("ObjLabel17-3",OBJPROP_YDISTANCE,li_0);
   if(ordersBuy > 0)
   {
      ObjectSetText("ObjLabel17-4",DoubleToString( (AccountEquity() - AccountCredit())/(buyTotalLot*10) ,2),displayFontSize,"Arial Bold",c);
      ObjectSet("ObjLabel17-4",OBJPROP_CORNER,corner);
      ObjectSet("ObjLabel17-4",OBJPROP_XDISTANCE,(displayXcord+180));
      ObjectSet("ObjLabel17-4",OBJPROP_YDISTANCE,li_0);
   }
   li_0 += displayYcord ;
   if(sellProfit >= 0)
   {
      c = c1;
   }else{
      c = c2;
   }
   
   ObjectSetText("ObjLabel18","Sell",displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel18",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel18",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel18",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel18-1",IntegerToString(ordersSell),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel18-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel18-1",OBJPROP_XDISTANCE,(displayXcord+40));
   ObjectSet("ObjLabel18-1",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel18-2",DoubleToString(sellTotalLot,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel18-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel18-2",OBJPROP_XDISTANCE,(displayXcord+80));
   ObjectSet("ObjLabel18-2",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel18-3",DoubleToString(sellProfit,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel18-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel18-3",OBJPROP_XDISTANCE,(displayXcord+120));
   ObjectSet("ObjLabel18-3",OBJPROP_YDISTANCE,li_0);
   
   if(ordersSell > 0){
      ObjectSetText("ObjLabel18-4",DoubleToString((AccountEquity() - AccountCredit())/(sellTotalLot*10),2),displayFontSize,"Arial Bold",c);
      ObjectSet("ObjLabel18-4",OBJPROP_CORNER,corner);
      ObjectSet("ObjLabel18-4",OBJPROP_XDISTANCE,(displayXcord+180));
      ObjectSet("ObjLabel18-4",OBJPROP_YDISTANCE,li_0);
   }
   
   
   
   li_0 += displayYcord ;
   
   if(buyProfit+sellProfit >= 0)
   {
      c = c1;
   }else{
      c = c2;
   }
   ObjectSetText("ObjLabel19","B&S",displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel19",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel19",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel19",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel19-1",IntegerToString(ordersBuy+ordersSell),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel19-1",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel19-1",OBJPROP_XDISTANCE,(displayXcord+40));
   ObjectSet("ObjLabel19-1",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel19-2",DoubleToString(buyTotalLot+sellTotalLot,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel19-2",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel19-2",OBJPROP_XDISTANCE,(displayXcord+80));
   ObjectSet("ObjLabel19-2",OBJPROP_YDISTANCE,li_0);
   
   ObjectSetText("ObjLabel19-3",DoubleToString(buyProfit+sellProfit,2),displayFontSize,"Arial Bold",c);
   ObjectSet("ObjLabel19-3",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel19-3",OBJPROP_XDISTANCE,(displayXcord+120));
   ObjectSet("ObjLabel19-3",OBJPROP_YDISTANCE,li_0);
   
   if(buyTotalLot - sellTotalLot != 0)
   {
      ObjectSetText("ObjLabel19-4",DoubleToString((AccountEquity() - AccountCredit())/(MathAbs(buyTotalLot+sellTotalLot)*10),2),displayFontSize,"Arial Bold",c);
      ObjectSet("ObjLabel19-4",OBJPROP_CORNER,corner);
      ObjectSet("ObjLabel19-4",OBJPROP_XDISTANCE,(displayXcord+180));
      ObjectSet("ObjLabel19-4",OBJPROP_YDISTANCE,li_0);
   }
   
   
   li_0 += displayYcord ;
   ObjectSetText("ObjLabel20",StringConcatenate("Deposit：",DoubleToString(deposit,2),"   Withdrawal：",DoubleToString(without,2)),displayFontSize,"Arial Bold",White);
   ObjectSet("ObjLabel20",OBJPROP_CORNER,corner);
   ObjectSet("ObjLabel20",OBJPROP_XDISTANCE,(displayXcord));
   ObjectSet("ObjLabel20",OBJPROP_YDISTANCE,li_0);
   
   
   //Draw Line
   if(ordersBuy > 1)
   {
      double argBuyPrice = buyTotalAmount/buyTotalLot;
      HorizontalLine(argBuyPrice,"line_buy",DodgerBlue,STYLE_DASH,1);
   }else if(ordersBuy <= 1)
   {
      ObjectDelete("line_buy");
   }
   
   if(ordersSell > 1)
   {  
      double argSellPrice = sellTotalAmount/sellTotalLot;
      HorizontalLine(argSellPrice,"line_sell",HotPink,STYLE_DASH,1);
      
   }else if(ordersSell <= 1)
   {
      ObjectDelete("line_sell");
   }
   
   return 0;
}


void HorizontalLine(double value, string name, color c, int style, int thickness) 
{
  if(ObjectFind(name) == -1)
  {
    ObjectCreate(name, OBJ_HLINE, 0, Time[0], value);
    
    ObjectSet(name, OBJPROP_STYLE, style);             
    ObjectSet(name, OBJPROP_COLOR, c);
    ObjectSet(name,OBJPROP_WIDTH,thickness);
  }
  else
  {
    ObjectSet(name,OBJPROP_PRICE1,value);
    ObjectSet(name, OBJPROP_STYLE, style);             
    ObjectSet(name, OBJPROP_COLOR, c);
    ObjectSet(name,OBJPROP_WIDTH,thickness);
  }  
}



void LabelCreate(){    
        if (displayOverlay ) {
            ObjectCreate("ObjBg",OBJ_RECTANGLE_LABEL,0,0,0);
            
            ObjectCreate("ObjLabel1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel3",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel4",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel5",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel6",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel7",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel7-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel7-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel7-3",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel8",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel8-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel8-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel8-3",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel9",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel9-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel9-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel9-3",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel10",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel10-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel10-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel10-3",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel11",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel11-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel11-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel11-3",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel12",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel12-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel12-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel12-3",OBJ_LABEL,0,0,0);
            
            ObjectCreate("ObjLabelpw",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabelpw-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabelpw-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabelpw-3",OBJ_LABEL,0,0,0);
            
            ObjectCreate("ObjLabel13",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel13-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel13-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel13-3",OBJ_LABEL,0,0,0);
            
            ObjectCreate("ObjLabelpm",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabelpm-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabelpm-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabelpm-3",OBJ_LABEL,0,0,0);
            
            ObjectCreate("ObjLabel14",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel14-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel14-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel14-3",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel15",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel16",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel17",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel17-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel17-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel17-3",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel17-4",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel18",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel18-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel18-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel18-3",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel18-4",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel19",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel19-1",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel19-2",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel19-3",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel19-4",OBJ_LABEL,0,0,0);
            ObjectCreate("ObjLabel20",OBJ_LABEL,0,0,0);
            
            
            }
        return;
}

void Refresh(){    
        if (displayOverlay) {
            ObjectDelete("ObjBg");
            ObjectDelete("ObjLabel1");
            ObjectDelete("ObjLabel2");
            ObjectDelete("ObjLabel3");
            ObjectDelete("ObjLabel4");
            ObjectDelete("ObjLabel5");
            ObjectDelete("ObjLabel6");
            ObjectDelete("ObjLabel7");
            ObjectDelete("ObjLabel7-1");
            ObjectDelete("ObjLabel7-2");
            ObjectDelete("ObjLabel7-3");
            ObjectDelete("ObjLabel8");
            ObjectDelete("ObjLabel8-1");
            ObjectDelete("ObjLabel8-2");
            ObjectDelete("ObjLabel8-3");
            ObjectDelete("ObjLabel9");
            ObjectDelete("ObjLabel9-1");
            ObjectDelete("ObjLabel9-2");
            ObjectDelete("ObjLabel9-3");
            ObjectDelete("ObjLabel10");
            ObjectDelete("ObjLabel10-1");
            ObjectDelete("ObjLabel10-2");
            ObjectDelete("ObjLabel10-3");
            ObjectDelete("ObjLabel11");
            ObjectDelete("ObjLabel11-1");
            ObjectDelete("ObjLabel11-2");
            ObjectDelete("ObjLabel11-3");
            ObjectDelete("ObjLabel12");
            ObjectDelete("ObjLabel12-1");
            ObjectDelete("ObjLabel12-2");
            ObjectDelete("ObjLabel12-3");
            ObjectDelete("ObjLabel13");
            ObjectDelete("ObjLabel13-1");
            ObjectDelete("ObjLabel13-2");
            ObjectDelete("ObjLabel13-3");
            
            ObjectDelete("ObjLabelpw");
            ObjectDelete("ObjLabelpw-1");
            ObjectDelete("ObjLabelpw-2");
            ObjectDelete("ObjLabelpw-3");
            ObjectDelete("ObjLabelpm");
            ObjectDelete("ObjLabelpm-1");
            ObjectDelete("ObjLabelpm-2");
            ObjectDelete("ObjLabelpm-3");
            
            ObjectDelete("ObjLabel14");
            ObjectDelete("ObjLabel14-1");
            ObjectDelete("ObjLabel14-2");
            ObjectDelete("ObjLabel14-3");
            ObjectDelete("ObjLabel15");
            ObjectDelete("ObjLabel16");
            ObjectDelete("ObjLabel17");
            ObjectDelete("ObjLabel17-1");
            ObjectDelete("ObjLabel17-2");
            ObjectDelete("ObjLabel17-3");
            ObjectDelete("ObjLabel17-4");
            ObjectDelete("ObjLabel18");
            ObjectDelete("ObjLabel18-1");
            ObjectDelete("ObjLabel18-2");
            ObjectDelete("ObjLabel18-3");
            ObjectDelete("ObjLabel18-4");
            ObjectDelete("ObjLabel19");
            ObjectDelete("ObjLabel19-1");
            ObjectDelete("ObjLabel19-2");
            ObjectDelete("ObjLabel19-3");
            ObjectDelete("ObjLabel19-4");
            ObjectDelete("ObjLabel20");
               
                } }