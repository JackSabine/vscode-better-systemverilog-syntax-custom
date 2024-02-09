// SYNTAX TEST "source-text.sv"
//
// Original source code by The SymbiFlow Authors under ISC License.
// Modifications by Shou-Li Hsu under MIT License.
// For full license information, see LICENSE file in the project root.
//
// vscode-tmgrammar-test annotations added by Shou-Li Hsu


/*
:name: distribution_1
:description: distribution test
:tags: uvm-random uvm
*/

import uvm_pkg::*;
`include "uvm_macros.svh"

class a;
    rand int b;
    constraint c { b dist {3 := 0, 10 := 5}; }
//                 ^ variable.other.sv
//                   ^^^^ keyword.other.dist.sv
//                        ^ punctuation.section.braces.begin.sv
//                         ^ constant.numeric.integer.sv
//                           ^^ keyword.operator.dist.sv
//                              ^ constant.numeric.integer.sv
//                               ^ punctuation.separator.comma.sv
//                                 ^^ constant.numeric.integer.sv
//                                    ^^ keyword.operator.dist.sv
//                                       ^ constant.numeric.integer.sv
//                                        ^ punctuation.section.braces.end.sv
//                                         ^ punctuation.terminator.semicolon.sv
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
      if(obj.b == 10) begin
        `uvm_info("RESULT", $sformatf("b = %0d SUCCESS", obj.b), UVM_LOW);
      end else begin
        `uvm_error("RESULT", $sformatf("b = %0d FAILED", obj.b));
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
