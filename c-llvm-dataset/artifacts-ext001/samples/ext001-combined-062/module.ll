; ModuleID = 'source.c'
source_filename = "source.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx27.2.0"

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @compute(i32 noundef %x, i32 noundef %y) #0 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %acc = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  store i32 %y, ptr %y.addr, align 4
  %0 = load i32, ptr %x.addr, align 4
  %1 = load i32, ptr %y.addr, align 4
  %2 = load i32, ptr %x.addr, align 4
  %3 = load i32, ptr %y.addr, align 4
  %sub = sub i32 %2, %3
  store i32 %sub, ptr %acc, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, ptr %i, align 4
  %5 = load i32, ptr %x.addr, align 4
  %and = and i32 %5, 15
  %6 = load i32, ptr %y.addr, align 4
  %and1 = and i32 %6, 1
  %add = add i32 %and, %and1
  %cmp = icmp ult i32 %4, %add
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %7 = load i32, ptr %acc, align 4
  %8 = load i32, ptr %y.addr, align 4
  %add2 = add i32 -1, %8
  %9 = load i32, ptr %acc, align 4
  %10 = load i32, ptr %i, align 4
  %and3 = and i32 %9, %10
  %sub4 = sub i32 %add2, %and3
  %xor = xor i32 %7, %sub4
  store i32 %xor, ptr %acc, align 4
  %11 = load i32, ptr %acc, align 4
  %12 = load i32, ptr %y.addr, align 4
  %shr = lshr i32 %12, 19
  %13 = load i32, ptr %i, align 4
  %14 = load i32, ptr %y.addr, align 4
  %sub5 = sub i32 %13, %14
  %sub6 = sub i32 %shr, %sub5
  %15 = load i32, ptr %y.addr, align 4
  %16 = load i32, ptr %y.addr, align 4
  %add7 = add i32 %15, %16
  %and8 = and i32 1, %add7
  %xor9 = xor i32 %sub6, %and8
  %xor10 = xor i32 %11, %xor9
  store i32 %xor10, ptr %acc, align 4
  %17 = load i32, ptr %x.addr, align 4
  %18 = load i32, ptr %y.addr, align 4
  %xor11 = xor i32 %17, %18
  %19 = load i32, ptr %i, align 4
  %xor12 = xor i32 %xor11, %19
  %and13 = and i32 %xor12, 512
  %cmp14 = icmp eq i32 %and13, 0
  br i1 %cmp14, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %20 = load i32, ptr %acc, align 4
  %21 = load i32, ptr %acc, align 4
  %xor15 = xor i32 %20, %21
  store i32 %xor15, ptr %acc, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %22 = load i32, ptr %acc, align 4
  %23 = load i32, ptr %acc, align 4
  %shl = shl i32 %23, 16
  %24 = load i32, ptr %x.addr, align 4
  %shl16 = shl i32 %24, 24
  %mul = mul i32 %shl, %shl16
  %xor17 = xor i32 %22, %mul
  store i32 %xor17, ptr %acc, align 4
  %25 = load i32, ptr %acc, align 4
  %26 = load i32, ptr %acc, align 4
  %27 = load i32, ptr %x.addr, align 4
  %or = or i32 %26, %27
  %xor18 = xor i32 %25, %or
  store i32 %xor18, ptr %acc, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %28 = load i32, ptr %i, align 4
  %inc = add i32 %28, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  %29 = load i32, ptr %x.addr, align 4
  %30 = load i32, ptr %y.addr, align 4
  %xor19 = xor i32 %29, %30
  %and20 = and i32 %xor19, 2048
  %cmp21 = icmp eq i32 %and20, 0
  br i1 %cmp21, label %if.then22, label %if.else26

if.then22:                                        ; preds = %for.end
  %31 = load i32, ptr %acc, align 4
  %32 = load i32, ptr %x.addr, align 4
  %xor23 = xor i32 %31, %32
  store i32 %xor23, ptr %acc, align 4
  %33 = load i32, ptr %acc, align 4
  %34 = load i32, ptr %x.addr, align 4
  %shr24 = lshr i32 %34, 28
  %xor25 = xor i32 %33, %shr24
  store i32 %xor25, ptr %acc, align 4
  br label %if.end28

if.else26:                                        ; preds = %for.end
  %35 = load i32, ptr %acc, align 4
  %36 = load i32, ptr %x.addr, align 4
  %xor27 = xor i32 %35, %36
  store i32 %xor27, ptr %acc, align 4
  br label %if.end28

if.end28:                                         ; preds = %if.else26, %if.then22
  %37 = load i32, ptr %acc, align 4
  ret i32 %37
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 27, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
