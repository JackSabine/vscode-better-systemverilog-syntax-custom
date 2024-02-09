// SYNTAX TEST "source-text.sv"
//
// Original source code by The SymbiFlow Authors under ISC License.
// Modifications by Shou-Li Hsu under MIT License.
// For full license information, see LICENSE file in the project root.
//
// vscode-tmgrammar-test annotations added by Shou-Li Hsu


/*
:name: post_randomize_method_1
:description: post_randomize() method test
:tags: uvm-random uvm
*/

import uvm_pkg::*;
`include "uvm_macros.svh"

class a;
    rand int b;
    int d;

    constraint c { b == 5; }
    function void post_randomize();
//                ^^^^^^^^^^^^^^ entity.name.function.sv
        d = 20;
    endfunction
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
      if(obj.b == 5 && obj.d == 20) begin
        `uvm_info("RESULT", $sformatf("obj.b = %0d obj.d = %0d SUCCESS", obj.b, obj.d), UVM_LOW);
      end else begin
        `uvm_error("RESULT", $sformatf("obj.b = %0d obj.d = %0d FAILED", obj.b, obj.d));
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
