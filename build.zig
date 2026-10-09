//! A fizzy plugin, as small as one gets. `zig build` produces the dylib the plugin store would
//! ship and installs it into fizzy's plugins directory; `fizzy.plugin.create` also exports the
//! same source as the `"plugin"` module, which is what an application bundles with
//! `fizzy.buildApp` (fizzyedit/example-app does).
const std = @import("std");
const fizzy = @import("fizzy");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const plugin = fizzy.plugin.create(b, .{ .target = target, .optimize = optimize });
    fizzy.plugin.install(b, plugin.lib, .{});
}
