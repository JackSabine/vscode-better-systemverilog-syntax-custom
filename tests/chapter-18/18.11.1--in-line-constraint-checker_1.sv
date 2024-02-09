// SYNTAX TEST "source-text.sv"
//
// Original source code by The SymbiFlow Authors under ISC License.
// Modifications by Shou-Li Hsu under MIT License.
// For full license information, see LICENSE file in the project root.
//
// vscode-tmgrammar-test annotations added by Shou-Li Hsu


/*
:name: in-line_constraint_checker_1
:description: in-line constraint checker test
:tags: uvm-random uvm
*/

import uvm_pkg::*;
`include "uvm_macros.svh"

class a;
    randc bit [7:0] x;
    bit [7:0] v;

    constraint c1 { x < v; };
endclass


class env extends uvm_env;

  a obj = new;
  int ret;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    begin
      obj.x = 2;
      obj.v = 1;
      ret = obj.randomize(null);

      if(ret == 0 && obj.x == 2 && obj.v == 1) begin
        `uvm_info("RESULT", $sformatf("obj.x = %0d obj.v = %0d SUCCESS", obj.x, obj.v), UVM_LOW);
      end else begin
        `uvm_error("RESULT", $sformatf("obj.x = %0d obj.v = %0d FAILED", obj.x, obj.v));
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
