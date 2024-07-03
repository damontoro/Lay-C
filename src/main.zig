const std = @import("std");
const fs = std.fs;

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alloc = arena.allocator();
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
    std.log.info("cwd: {s}", .{
        try std.fs.cwd().realpathAlloc(alloc, "."),
    });

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    var file = try fs.cwd().openFile("prueba.lc", .{});
    defer file.close();
    var reader = std.io.bufferedReader(file.reader());
    var in_stream = reader.reader();
    var buf: [1024]u8 = undefined;
    var stdout = std.io.getStdOut().writer();
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        _ = try stdout.write(line);
    }
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
