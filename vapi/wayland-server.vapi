[CCode (cprefix = "wl_", lower_case_cprefix = "wl_", cheader_filename = "wayland-server-core.h")]
namespace Wl {
    
    [Compact]
	[CCode (cname = "struct wl_display", free_function = "wl_display_destroy")]
	public class Display {
        [CCode (cname = "wl_display_create")]
        public Display();
        public void run();
        public Wl.EventLoop get_event_loop();
    }
    
    [Compact]
	[CCode (cname = "struct wl_message")]
	public class Message {
	}
	
    [Compact]
    [CCode (cname = "struct wl_event_loop", free_function = "wl_event_loop_destroy")]
    public class EventLoop {
        
    }
    
    [CCode (cname = "struct wl_signal", free_function = "")]
    public struct Signal {
        public void add(Listener listener);
    }
    
    [CCode (cname = "struct wl_listener", free_function = "")]
    public struct Listener {
        public NotifyFunc notify;
    }
    
    [CCode (cname = "wl_notify_func_t", has_target = false)]
    public delegate void NotifyFunc(Listener listener, void* data);
}