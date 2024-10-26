project(
    'vala-roots',
    
    ['c', 'vala'],
    version: '1.0',
    meson_version: '>= 0.50.0',
)

vapi_dir = meson.current_source_dir() / 'vapi'

add_global_arguments([
	'-Wno-unused',
	'-Wno-discarded-qualifiers'
], language: 'c')

# Load custom vapi files
add_project_arguments(
    [ '--vapidir', vapi_dir ],
    language: 'vala'
)

name = meson.project_name()
version = meson.project_version()
output = name.to_lower()

subdir('src')