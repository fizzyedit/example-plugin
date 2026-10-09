# example-plugin

The smallest [fizzy](https://github.com/fizzyedit/fizzy) plugin: one surface in the sidebar that
says hello. Copy this repo to start a plugin of your own.

## Build and try it

```sh
zig build
```

This builds `zig-out/hello.dylib` (`.so` on Linux, `.dll` on Windows) and installs it into
fizzy's plugins directory, `<config>/fizzy/plugins/hello/`. Start fizzy and "Hello" is in the
sidebar.

To keep it out of your own fizzy while you work, point both the build and the fizzy you start at
a profile directory of their own (the build honours it from fizzy SDK 0.2.19):

```sh
FIZZY_PROFILE=$PWD/.profile zig build
fizzy --profile $PWD/.profile
```

## What is here

| File | What it is |
|---|---|
| `plugin.zig.zon` | The plugin's identity: `id`, `name`, `version`, `description`. Nothing else. |
| `plugin.zig` | `register(host)` and the plugin's hooks. What the plugin does is only what it registers here. |
| `build.zig` | Two lines: `fizzy.plugin.create` builds the dylib (and exports the source as the `"plugin"` module, for apps that bundle it), `fizzy.plugin.install` installs it. |
| `build.zig.zon` | The package, pinning the fizzy SDK by its release asset. |

The full contract (every hook, the lifecycle, settings, documents) is fizzy's
[`docs/PLUGINS.md`](https://github.com/fizzyedit/fizzy/blob/main/docs/PLUGINS.md).

## Make it yours

1. Copy the repo.
2. In `plugin.zig.zon`, give it an `id` of your own, and its `name` and `description`. The `id`
   is what the store and the plugins directory know it by; keep it short, lowercase, no dots.
3. In `build.zig.zon`, rename `.name` to match, and delete the `.fingerprint` line. Zig prints a
   new one on the next build; paste it back in.
4. In `plugin.zig`, prefix every id you register with your plugin's id (`hello.greeting` here).

## Publish it

Tag a version and `.github/workflows/release.yml` builds it for every platform fizzy runs on and
attaches the builds and a manifest to the release. The tag must equal `version` in
`plugin.zig.zon`. To list it in fizzy's plugin store, add it to
[fizzyedit/plugins](https://github.com/fizzyedit/plugins).

## Staying current

When fizzy releases a new SDK, `.github/workflows/sdk-repin.yml` builds the plugin against it and
opens a pull request moving the pin, when the plugin needs one. Run it by hand from the Actions tab
at any time. It needs "Allow GitHub Actions to create and approve pull requests" in the repo's
Actions settings.
