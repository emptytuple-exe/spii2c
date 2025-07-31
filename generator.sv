class generator;
      
      transaction tr;
      mailbox #(transaction) mbx;
      event done;
      int count = 0;
      event drvnext;
      event sconext;
      
      // Constructor
      function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
        tr = new();
      endfunction
      
      // Task to generate transactions
      task run();
        repeat(count) begin
          assert(tr.randomize) else $error("[GEN] :Randomization Failed");
          mbx.put(tr.copy);
          tr.display("GEN");
          @(drvnext);
          @(sconext);
        end
        -> done;
      endtask
      
    endclass