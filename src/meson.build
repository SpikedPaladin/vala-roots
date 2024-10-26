deps = [
    dependency('wayland-server'),
    dependency('wlroots-0.18'),
    dependency('glib-2.0'),
    dependency('gobject-2.0')
]

sources = files(
    'main.vala',
)

executable(
    output,
    
    sources,
    dependencies: deps,
    c_args: [ '-DWLR_USE_UNSTABLE' ],
    install: true,
)
