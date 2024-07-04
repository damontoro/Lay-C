const std = @import("std");
const fs = @import("std.fs");

pub const Parser = struct {
    var reader: std.io.GenericReader(comptime Context: type, comptime ReadError: type, comptime readFn: fn(context:Context, buffer:[]u8)ReadError!usize)
};
