// SYNTAX TEST "source-text.sv"
//
// Original source code by The SymbiFlow Authors under ISC License.
// Modifications by Shou-Li Hsu under MIT License.
// For full license information, see LICENSE file in the project root.
//
// vscode-tmgrammar-test annotations added by Shou-Li Hsu


/*
:name: behavior_of_randomization_methods_2
:description: If randomize() fails, the constraints are infeasible, and the random variables retain their previous values.
:tags: uvm-random uvm
*/

import uvm_pkg::*;
`include "uvm_macros.svh"

class a;
    rand int b = 1;

    /* Create infeasible constraint */
    constraint c { b == 0 && b > 0; }
endclass

class env extends uvm_env;

  a obj = new;
  int prev_value, status;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    begin
      prev_value = obj.b;
      status = obj.randomize();

      if(status == 0 && prev_value == obj.b) begin
        `uvm_info("RESULT", $sformatf("obj.b = %0d prev_value = %0d SUCCESS", obj.b, prev_value), UVM_LOW);
      end else begin
        `uvm_error("RESULT", $sformatf("obj.b = %0d prev_value = %0d FAILED", obj.b, prev_value));
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
