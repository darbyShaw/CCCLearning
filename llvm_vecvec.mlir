module {
  func.func @matmul(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?x?xf32>) {
    %0 = llvm.mlir.constant(3 : index) : i64
    %1 = llvm.mlir.constant(2 : index) : i64
    %2 = llvm.mlir.constant(-1 : index) : i64
    %3 = llvm.mlir.constant(4 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(0 : index) : i64
    %6 = builtin.unrealized_conversion_cast %5 : i64 to index
    %7 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = builtin.unrealized_conversion_cast %arg1 : memref<?xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = builtin.unrealized_conversion_cast %arg2 : memref<?x?xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)>
    %10 = llvm.extractvalue %7[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = builtin.unrealized_conversion_cast %10 : i64 to index
    %12 = llvm.extractvalue %8[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = builtin.unrealized_conversion_cast %12 : i64 to index
    cf.br ^bb1(%6 : index)
  ^bb1(%14: index):  // 2 preds: ^bb0, ^bb8
    %15 = builtin.unrealized_conversion_cast %14 : index to i64
    %16 = builtin.unrealized_conversion_cast %14 : index to i64
    %17 = llvm.icmp "slt" %15, %10 : i64
    llvm.cond_br %17, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    %18 = llvm.icmp "slt" %12, %5 : i64
    %19 = llvm.sub %2, %12  : i64
    %20 = llvm.select %18, %19, %12 : i1, i64
    %21 = llvm.sdiv %20, %3  : i64
    %22 = llvm.sub %2, %21  : i64
    %23 = llvm.select %18, %22, %21 : i1, i64
    %24 = llvm.mul %23, %3  : i64
    cf.br ^bb3(%6 : index)
  ^bb3(%25: index):  // 2 preds: ^bb2, ^bb4
    %26 = builtin.unrealized_conversion_cast %25 : index to i64
    %27 = builtin.unrealized_conversion_cast %25 : index to i64
    %28 = llvm.icmp "slt" %26, %24 : i64
    llvm.cond_br %28, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %29 = llvm.extractvalue %7[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.getelementptr %29[%16] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %31 = llvm.load %30 : !llvm.ptr<f32>
    %32 = llvm.extractvalue %8[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.getelementptr %32[%27] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %34 = llvm.load %33 : !llvm.ptr<f32>
    %35 = llvm.fmul %31, %34  : f32
    %36 = llvm.extractvalue %9[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.extractvalue %9[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.mul %16, %37  : i64
    %39 = llvm.add %38, %27  : i64
    %40 = llvm.getelementptr %36[%39] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %35, %40 : !llvm.ptr<f32>
    %41 = llvm.add %26, %4  : i64
    %42 = builtin.unrealized_conversion_cast %41 : i64 to index
    %43 = llvm.extractvalue %7[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %44 = llvm.getelementptr %43[%16] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %45 = llvm.load %44 : !llvm.ptr<f32>
    %46 = llvm.extractvalue %8[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %47 = llvm.getelementptr %46[%41] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %48 = llvm.load %47 : !llvm.ptr<f32>
    %49 = llvm.fmul %45, %48  : f32
    %50 = llvm.extractvalue %9[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.extractvalue %9[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.mul %16, %51  : i64
    %53 = llvm.add %52, %41  : i64
    %54 = llvm.getelementptr %50[%53] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %49, %54 : !llvm.ptr<f32>
    %55 = llvm.add %26, %1  : i64
    %56 = builtin.unrealized_conversion_cast %55 : i64 to index
    %57 = llvm.extractvalue %7[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %58 = llvm.getelementptr %57[%16] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %59 = llvm.load %58 : !llvm.ptr<f32>
    %60 = llvm.extractvalue %8[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %61 = llvm.getelementptr %60[%55] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %62 = llvm.load %61 : !llvm.ptr<f32>
    %63 = llvm.fmul %59, %62  : f32
    %64 = llvm.extractvalue %9[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)> 
    %65 = llvm.extractvalue %9[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)> 
    %66 = llvm.mul %16, %65  : i64
    %67 = llvm.add %66, %55  : i64
    %68 = llvm.getelementptr %64[%67] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %63, %68 : !llvm.ptr<f32>
    %69 = llvm.add %26, %0  : i64
    %70 = builtin.unrealized_conversion_cast %69 : i64 to index
    %71 = llvm.extractvalue %7[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %72 = llvm.getelementptr %71[%16] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %73 = llvm.load %72 : !llvm.ptr<f32>
    %74 = llvm.extractvalue %8[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %75 = llvm.getelementptr %74[%69] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %76 = llvm.load %75 : !llvm.ptr<f32>
    %77 = llvm.fmul %73, %76  : f32
    %78 = llvm.extractvalue %9[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)> 
    %79 = llvm.extractvalue %9[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)> 
    %80 = llvm.mul %16, %79  : i64
    %81 = llvm.add %80, %69  : i64
    %82 = llvm.getelementptr %78[%81] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %77, %82 : !llvm.ptr<f32>
    %83 = llvm.add %26, %3  : i64
    %84 = builtin.unrealized_conversion_cast %83 : i64 to index
    cf.br ^bb3(%84 : index)
  ^bb5:  // pred: ^bb3
    %85 = llvm.icmp "slt" %12, %5 : i64
    %86 = llvm.sub %2, %12  : i64
    %87 = llvm.select %85, %86, %12 : i1, i64
    %88 = llvm.sdiv %87, %3  : i64
    %89 = llvm.sub %2, %88  : i64
    %90 = llvm.select %85, %89, %88 : i1, i64
    %91 = llvm.mul %90, %3  : i64
    %92 = builtin.unrealized_conversion_cast %91 : i64 to index
    cf.br ^bb6(%92 : index)
  ^bb6(%93: index):  // 2 preds: ^bb5, ^bb7
    %94 = builtin.unrealized_conversion_cast %93 : index to i64
    %95 = builtin.unrealized_conversion_cast %93 : index to i64
    %96 = llvm.icmp "slt" %94, %12 : i64
    llvm.cond_br %96, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %97 = llvm.extractvalue %7[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %98 = llvm.getelementptr %97[%16] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %99 = llvm.load %98 : !llvm.ptr<f32>
    %100 = llvm.extractvalue %8[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<1 x i64>, array<1 x i64>)> 
    %101 = llvm.getelementptr %100[%95] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %102 = llvm.load %101 : !llvm.ptr<f32>
    %103 = llvm.fmul %99, %102  : f32
    %104 = llvm.extractvalue %9[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)> 
    %105 = llvm.extractvalue %9[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.mul %16, %105  : i64
    %107 = llvm.add %106, %95  : i64
    %108 = llvm.getelementptr %104[%107] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %103, %108 : !llvm.ptr<f32>
    %109 = llvm.add %94, %4  : i64
    %110 = builtin.unrealized_conversion_cast %109 : i64 to index
    cf.br ^bb6(%110 : index)
  ^bb8:  // pred: ^bb6
    %111 = llvm.add %15, %4  : i64
    %112 = builtin.unrealized_conversion_cast %111 : i64 to index
    cf.br ^bb1(%112 : index)
  ^bb9:  // pred: ^bb1
    return
  }
}

