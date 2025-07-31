class scoreboard;
      mailbox #(bit [11:0]) mbxds, mbxms;
      bit [11:0] ds; // Data from driver
      bit [11:0] ms; // Data from monitor
      event sconext;
     
      // Constructor
      function new(mailbox #(bit [11:0]) mbxds, mailbox #(bit [11:0]) mbxms);
        this.mbxds = mbxds;
        this.mbxms = mbxms;
      endfunction
     
      // Task to compare data from driver and monitor
      task run();
        forever begin
          mbxds.get(ds);
          mbxms.get(ms);
          $display("[SCO] : DRV : %0d MON : %0d", ds, ms);
     
          if (ds == ms)
            $display("[SCO] : DATA MATCHED");
          else
            $display("[SCO] : DATA MISMATCHED");
     
          $display("-----------------------------------------");
          ->sconext;
        end
      endtask
    endclass