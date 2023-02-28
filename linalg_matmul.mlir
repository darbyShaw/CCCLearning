#matmul_accesses = [
  affine_map<(m, n, k) -> (m, k)>,
  affine_map<(m, n, k) -> (k, n)>,
  affine_map<(m, n, k) -> (m, n)>
]

#matmul_trait = {
  doc = "C(m, n) += A(m, k) * B(k, n)",
  indexing_maps = #matmul_accesses,
  library_call = "linalg_matmul",
  iterator_types = ["parallel", "parallel", "reduction"]
}

func.func @_matmul(%tensor1: memref<?x?xf64>, %tensor2: memref<?x?xf64>, %tensor3: memref<?x?xf64>) -> ()  {
  %0 = arith.constant 0.0 : f64
  linalg.fill ins(%0 : f64) outs(%tensor3: memref<?x?xf64>)
  linalg.generic #matmul_trait
  	ins(%tensor1, %tensor2 : memref<?x?xf64>, memref<?x?xf64>) outs(%tensor3: memref<?x?xf64>) {
  	^bb0(%a: f64, %b: f64, %c: f64) :
    	%d = arith.mulf %a, %b: f64
    	%e = arith.addf %c, %d: f64
    	linalg.yield %e : f64
  }
  return
}

func.func @matmul(%tensor1: tensor<?x?xf64>, %tensor2: tensor<?x?xf64>) -> tensor<?x?xf64>  {
  %0 = arith.constant 0 : index
  %1 = arith.constant 1 : index
  %m = tensor.dim %tensor1, %0 : tensor<?x?xf64>
  %n = tensor.dim %tensor2, %1 : tensor<?x?xf64>
  %tensor3 = tensor.generate %m, %n {
	^bb0(%i : index, %j : index):
	%elem = arith.constant 0.0 : f64
	tensor.yield %elem : f64
  } : tensor<?x?xf64>

  %tensor4 = linalg.generic #matmul_trait
  	ins(%tensor1, %tensor2 : tensor<?x?xf64>, tensor<?x?xf64>) outs(%tensor3: tensor<?x?xf64>) {
  	^bb0(%a: f64, %b: f64, %c: f64) :
    	%d = arith.mulf %a, %b: f64
    	%e = arith.addf %c, %d: f64
    	linalg.yield %e : f64
  } -> tensor<?x?xf64>
  return %tensor4 : tensor<?x?xf64>
}
