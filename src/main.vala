public class State {
    public weak Wl.Display display;

    public Wl.Listener new_output_listener;
    [CCode (cname = "offsetof(State, new_output_listener)")]
    extern const int new_output_offset;

    public Wl.Listener new_input_listener;
    [CCode (cname = "offsetof(State, new_input_listener)")]
    extern const int new_input_offset;
    
    public Wlr.Renderer renderer;
    public Wlr.Allocator allocator;
    
    public SampleOutput sample_output;

    public State() {
        new_output_listener.notify = _new_output;
        new_input_listener.notify = _new_input;
    }

    public static void _new_output(Wl.Listener listener, void* data) {
        unowned Wlr.Output output = (Wlr.Output) data;
        unowned var self = Utils.get_listener_parent<State>(ref listener, new_output_offset);

        self.new_output(output);
    }

    public void new_output(Wlr.Output output) {
        output.init_render(allocator, renderer);
        
        sample_output = new SampleOutput() {
            output = output
        };
        
        var output_state = Wlr.OutputState();
        output_state.set_enabled(true);
        if (output.preferred_mode != null) {
            output_state.set_mode(output.preferred_mode);
        }
        
        output.commit_state(output_state);
    }

    public static void _new_input(Wl.Listener listener, void* data) {
        unowned var self = Utils.get_listener_parent<State>(ref listener, new_input_offset);

        self.new_input();
    }

    public void new_input() {
        Wlr.log(Wlr.LogImportance.INFO, "New input");
    }
}

public class SampleOutput {
    public unowned Wlr.Output output;
    public Wl.Listener frame;
    public Wl.Listener destroy;
}

public State state;

public void main() {
    Wlr.log_init(Wlr.LogImportance.DEBUG);
    var display = new Wl.Display();
    state = new State() {
        display = display
    };
    
    var backend = new Wlr.Backend(display.get_event_loop());
    if (backend == null) {
        Wlr.log(Wlr.LogImportance.ERROR, "Failed to create backend");
        return;
    }
    
    state.renderer = new Wlr.Renderer(backend);
    state.allocator = new Wlr.Allocator(backend, state.renderer);
    
    backend.new_output.add(ref state.new_output_listener);
    backend.new_input.add(ref state.new_input_listener);
    
    if (!backend.start()) {
        Wlr.log(Wlr.LogImportance.ERROR, "Backend failed to start");
        return;
    }
    
    display.run();
}