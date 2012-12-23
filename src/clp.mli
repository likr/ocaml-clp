(* Copyright (C) 2012 Yosuke Onoue *)

(**
 * OCaml bindings to CLP (COIN-OR LP).
 *
 * @author Yosuke Onoue
 *)

(** {2 Types} *)

type t;;

type direction = Maximize | Minimize;;

type row = {
  row_lower : float;
  row_upper : float;
  row_elements : (int * float) array};;

type column = {
  column_obj : float;
  column_lower : float;
  column_upper : float;
  column_elements : (int * float) array};;

(** {2 Creating model} *)

(** [create ()] returns new empty model. *)
val create : unit -> t;;

(** {2 Getters and setters of problem parameters} *)

(** [resize model num_rows num_cols] modifies the size of [model]. *)
val resize : t -> int -> int -> unit;;

(** [number_rows model] returns the number of rows of [model]. *)
val number_rows : t -> int;;

(** [number_columns model] returns the number of columns of [model]. *)
val number_columns : t -> int;;

(** [direction mode] returns the direction of [model]. *)
val direction : t -> direction;;

(** [set_direction model d] modifies the direction of [model] to [d]. *)
val set_direction : t -> direction -> unit;;

(** [add_rows model rows] adds rows to [model]. *)
val add_rows : t -> row array -> unit;;

(** [delete_rows model which] deletes rows from [model]. *)
val delete_rows : t -> int array -> unit;;

(** [add_columns model columns] adds columns to [model]. *)
val add_columns : t -> column array -> unit;;

(** [delete_columns model which] deletes columns from [model]. *)
val delete_columns : t -> int array -> unit;;

(** [row_lower model] returns row lower values of [model]. *)
val row_lower : t -> float array;;

(** [change_row_lower model v] modifies row lower values of [model]. *)
val change_row_lower : t -> float array -> unit;;

(** [row_upper model] returns row upper values of [model]. *)
val row_upper : t -> float array;;

(** [change_row_upper model v] modifies row upper values of [model]. *)
val change_row_upper : t -> float array -> unit;;

(** [column_lower model] returns column lower values of [model]. *)
val column_lower : t -> float array;;

(** [change_column_lower model v] modifies column lower values of [model]. *)
val change_column_lower : t -> float array -> unit;;

(** [column_upper model] returns column upper values of [model]. *)
val column_upper : t -> float array;;

(** [change_column_upper model v] modifies column upper values of [model]. *)
val change_column_upper : t -> float array -> unit;;

(** [objective_coefficients model] returns objective coefficient values of
 * [model]. *)
val objective_coefficients : t -> float array;;

(** [change_objective_coefficients model v] modifies objective coefficient
 * values of [model] *)
val change_objective_coefficients : t -> float array -> unit;;

(** {2 Getters and setters of solver parameters} *)

(** [log_level model] returns the log level of [model]. *)
val log_level : t -> int;;

(** [set_log_level model l] modifies log level of [model] to [l]. *)
val set_log_level : t -> int -> unit;;

(** {2 Solver operations} *)

(** [primal model] solves [model] using primal simplex method. *)
val primal : t -> unit;;

(** [dual model] solves [model] using dual simplex method. *)
val dual : t -> unit;;

(** {2 Retrieving solutions} *)

(** [objective_value model] returns the objective value of [model]. *)
val objective_value : t -> float;;

(** [primal_row_solution model] returns the primal row solution of [model]. *)
val primal_row_solution : t -> float array;;

(** [primal_row_solution model] returns the primal column solution of [model]. *)
val primal_column_solution : t -> float array;;

(** [primal_row_solution model] returns the dual row solution of [model]. *)
val dual_row_solution : t -> float array;;

(** [primal_row_solution model] returns the dual column solution of [model]. *)
val dual_column_solution : t -> float array;;
