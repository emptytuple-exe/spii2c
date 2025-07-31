class driver;
      
      virtual spi_if vif;
      transaction tr;
      mailbox #(transaction) mbx;
      mailbox #(bit [11:0]) mbxds;
      event drvnext;
      
      bit [11:0] din;
     
      // Constructor
      function new(mailbox #(bit [11:0]) mbxds, mailbox #(transaction) mbx);
        this.mbx = mbx;
        this.mbxds = mbxds;
      endfunction
      
      // Task to reset the driver
      task reset();
         vif.rst <= 1'b1;
         vif.cs <= 1'b1;
         vif.newd <= 1'b0;
         vif.din <= 1'b0;
         vif.mosi <= 1'b0;
        repeat(10) @(posedge vif.clk);
          vif.rst <= 1'b0;
        repeat(5) @(posedge vif.clk);
     
        $display("[DRV] : RESET DONE");
        $display("-----------------------------------------");
      endtask
      
      // Task to drive transactions
      task run();
        forever begin
          mbx.get(tr);
          @(posedge vif.sclk);
          vif.newd <= 1'b1;
          vif.din <= tr.din;
          mbxds.put(tr.din);
          @(posedge vif.sclk);
          vif.newd <= 1'b0;
          wait(vif.cs == 1'b1);
          $display("[DRV] : DATA SENT TO DAC : %0d",tr.din);
          ->drvnext;
        end
      endtask
      
    endclass