// SYNTAX TEST "source-text.sv"
//
// Original source code by The SymbiFlow Authors under ISC License.
// Modifications by Shou-Li Hsu under MIT License.
// For full license information, see LICENSE file in the project root.
//
// vscode-tmgrammar-test annotations added by Shou-Li Hsu


/*
:name: random_stability_0
:description: random stability - urandom_range test
:tags: uvm-random uvm
*/

import uvm_pkg::*;
`include "uvm_macros.svh"

class env extends uvm_env;
  int unsigned val1, val2;
  process p;
  string randstate;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    begin
      p = process::self();
      randstate = p.get_randstate();
      val1 = $urandom_range(0, 1000);
      p.set_randstate(randstate);
      val2 = $urandom_range(0, 1000);

      if(val1 == val2) begin
        `uvm_info("RESULT", $sformatf("val1 = %0d val2 = %0d SUCCESS", val1, val2), UVM_LOW);
      end else begin
        `uvm_error("RESULT", $sformatf("val1 = %0d val2 = %0d FAILED", val1, val2));
      end
    end
    phase.drop_objection(this);
  endtask: run_phase
  
endclass

module top;

  env environment;

  initial begin
    environment = new("env");
    run_test();
  end
  
endmodule
