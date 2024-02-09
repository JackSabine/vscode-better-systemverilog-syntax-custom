// SYNTAX TEST "source-text.sv"
//
// Original source code by The SymbiFlow Authors under ISC License.
// Modifications by Shou-Li Hsu under MIT License.
// For full license information, see LICENSE file in the project root.
//
// vscode-tmgrammar-test annotations added by Shou-Li Hsu


/*
:name: functions_in_constraint_1
:description: functions in constraint test
:tags: uvm-random uvm
*/

import uvm_pkg::*;
`include "uvm_macros.svh"

class a;
    rand int b1, b2;
    function int F (input int d);
        F=d;
    endfunction

    constraint c1 { b1 == 5; }
    constraint c2 { b2 == F(b1); }
endclass

class env extends uvm_env;

  a obj = new;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    begin
      obj.randomize();
      if(obj.b2 == 5) begin
        `uvm_info("RESULT", $sformatf("obj.b2 = %0d SUCCESS", obj.b2), UVM_LOW);
      end else begin
        `uvm_error("RESULT", $sformatf("obj.b2 = %0d FAILED", obj.b2));
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
