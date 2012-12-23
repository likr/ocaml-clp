open OUnit;;


let problem () =
  let model = Clp.create () in
  let columns = [|
    {Clp.column_lower = 0.; column_upper = infinity; column_obj = 6.;
      column_elements = [|(0, 2.); (1, 3.)|]};
    {Clp.column_lower = 0.; column_upper = infinity; column_obj = 5.;
      column_elements = [|(0, 1.); (1, 4.)|]}|]
  in
  Clp.set_log_level model 0;
  Clp.set_direction model Clp.Maximize;
  Clp.resize model 2 0;
  Clp.add_columns model columns;
  Clp.change_row_lower model [|0.; 0.|];
  Clp.change_row_upper model [|5.; 10.|];
  model;;


let test_resize () =
  let model = Clp.create () in
  let row, col = 10, 12 in
  Clp.resize model row col;
  assert_equal row (Clp.number_rows model);
  assert_equal col (Clp.number_columns model);;


let test_direction () =
  let model = Clp.create () in
  assert_equal Clp.Minimize (Clp.direction model);
  Clp.set_direction model Clp.Maximize;
  assert_equal Clp.Maximize (Clp.direction model);;


let test_add_rows () =
  let model = Clp.create () in
  let rows = [|
    {Clp.row_lower = 0.; row_upper = 100.;
      row_elements = [|(0, 1.); (1, 1.); (2, 1.)|]};
    {Clp.row_lower = 0.; row_upper = 600.;
      row_elements = [|(0, 10.); (1, 4.); (2, 5.)|]};
    {Clp.row_lower = 0.; row_upper = 300.;
      row_elements = [|(0, 2.); (1, 2.); (2, 6.)|]}|]
  in
  Clp.resize model 0 3;
  Clp.add_rows model rows;
  assert_equal 3 (Clp.number_rows model);;


let test_add_columns () =
  let model = Clp.create () in
  let columns = [|
    {Clp.column_lower = 0.; column_upper = infinity; column_obj = 10.;
      column_elements = [|(0, 1.); (1, 10.); (2, 2.)|]};
    {Clp.column_lower = 0.; column_upper = infinity; column_obj = 6.;
      column_elements = [|(0, 1.); (1, 4.); (2, 2.)|]};
    {Clp.column_lower = 0.; column_upper = infinity; column_obj = 4.;
      column_elements = [|(0, 1.); (1, 5.); (2, 6.)|]}|]
  in
  Clp.resize model 3 0;
  Clp.add_columns model columns;
  assert_equal 3 (Clp.number_columns model);;


let test_log_level () =
  let model = Clp.create () in
  Clp.set_log_level model 0;
  assert_equal 0 (Clp.log_level model);;


let test_row_upper () =
  let model = Clp.create () in
  let row_upper = [|100.; 600.; 300.|] in
  Clp.resize model 3 0;
  Clp.change_row_upper model row_upper;
  assert_equal row_upper (Clp.row_upper model);;


let test_row_lower () =
  let model = Clp.create () in
  let row_lower = [|0.; 0.; 0.|] in
  Clp.resize model 3 0;
  Clp.change_row_lower model row_lower;
  assert_equal row_lower (Clp.row_lower model);;


let test_primal () =
  let model = problem () in
  Clp.primal model;
  assert_equal 17. (Clp.objective_value model);;


let test_dual () =
  let model = problem () in
  Clp.dual model;
  assert_equal 17. (Clp.objective_value model);;


let suite =
  "test ocaml-clp" >::: [
    "test_resize" >:: test_resize;
    "test_direction" >:: test_direction;
    "test_add_rows" >:: test_add_rows;
    "test_add_columns" >:: test_add_columns;
    "test_row_upper" >:: test_row_upper;
    "test_row_lower" >:: test_row_lower;
    "test_log_level" >:: test_log_level;
    "test_primal" >:: test_primal;
    "test_dual" >:: test_dual];;

let _ =
  run_test_tt_main suite;;
