[CCode (cprefix = "wlr_", lower_case_cprefix = "wlr_")]
namespace Wlr {
    
    [CCode (cname = "wlr_log_importance", cprefix = "WLR_", has_type_id = false, cheader_filename = "wlr/util/log.h")]
    public enum LogImportance {
        SILENT,
        ERROR,
        INFO,
        DEBUG,
        LOG_IMPORTANCE_LAST;
    }
    
    [CCode (cname = "wlr_log_init", cheader_filename = "wlr/util/log.h")]
    public void log_init(LogImportance verbosity, void* callback = null);
    
    [CCode (cname = "wlr_log", cheader_filename = "wlr/util/log.h")]
    public void log(LogImportance verbosity, string format, ...);
    
    [Compact]
	[CCode (cname = "struct wlr_backend", free_function = "wlr_backend_destroy", cheader_filename = "wlr/backend.h")]
	public class Backend {
        [CCode (cname = "wlr_backend_autocreate")]
        public Backend(Wl.EventLoop loop, void* session_ptr = null);
        public bool start();
        
        [CCode (cname = "events.destroy")]
        public Wl.Signal destroy;
        [CCode (cname = "events.new_input")]
        public Wl.Signal new_input;
        [CCode (cname = "events.new_output")]
        public Wl.Signal new_output;
    }
    
    [Compact]
    [CCode (cname = "struct wlr_renderer", free_function = "", cheader_filename = "wlr/render/wlr_renderer.h")]
    public class Renderer {
        [CCode (cname = "wlr_renderer_autocreate")]
        public Renderer(Backend backend);
    }
    
    [Compact]
    [CCode (cname = "struct wlr_allocator", free_function = "", cheader_filename = "wlr/render/allocator.h")]
    public class Allocator {
        [CCode (cname = "wlr_allocator_autocreate")]
        public Allocator(Backend backend, Renderer renderer);
    }
    
    [Compact]
    [CCode (cname = "struct wlr_output", free_function = "", cheader_filename = "wlr/types/wlr_output.h")]
    public class Output {
        public void init_render(Allocator allocator, Renderer renderer);
    }
}