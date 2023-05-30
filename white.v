module pomodoro(
  input clk,
  input rst,
  input button,
  output reg red,
  output reg blue,
  output reg green
);

  reg [23:0] counter;

  integer second;
  integer break=0;
  integer pressed = 0;
  integer temp = 1;


  always @(posedge clk or negedge rst) begin
    if (!rst) begin

    end else begin
      if (second < 11 && break == 0 ) begin // Kırmızı ışık
        red <= 1'b0;
        blue <= 1'b1;
        green <= 1'b1;
        if(second == 10 )begin
        break = 1;
    end
      end 

      else if ( break ==1) begin // Sarı ışık 
        red <= 1'b0;
        blue <= 1'b1;
        green <= 1'b0;
       if(pressed==1)begin
        break = 2;
        second <= 0;

        if(pressed ==2)begin
            break = 0;
            second <= 0;

end


end
      end 

      else if (break==2 && second < 3) begin // Yeşil ışık 
        red <= 1'b1;
        blue <= 1'b1;
        green <= 1'b0;

       if(second == 2)begin
        break = break -2;
end


      end 


      counter <= counter + 1;
      //  Bu bölüm counter her counter her 24'd2400_0000 olduğunda yani her 1 
      //saniye geçtiğinde second ismindeki değişkeni 1 arttırıyor böylelikle 24'd2400_0000 gibi karmaşık yazımlardan
      // kurtulup direkt saniye üzerinden sınırlamaları koyabiliyoruz. 
      if (counter == 24'd2400_0000) begin
        counter <= 24'd0;
        second <= second + 1;
        if (second > 25 )begin
        second <= 0;
        end
      end
    end
  end
  always @(button,rst,clk) begin
   if(!button && rst)begin
    pressed = 1;
end

    if(button && !rst)begin
    pressed = 2;
end


end
endmodule