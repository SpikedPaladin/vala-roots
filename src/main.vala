public class State {
    public weak Wl.Display display;
    public Wl.Listener new_output;
    public Wl.Listener new_input;
    
    public Wlr.Renderer renderer;
    public Wlr.Allocator allocator;
}

public State state;

public void new_output(Wl.Listener listener, void* data) {
    unowned Wlr.Output output = (Wlr.Output) data;
    
    output.init_render(state.allocator, state.renderer);
}

public void new_input(Wl.Listener listener, void* data) {
    
}

public void main() {
    Wlr.log_init(Wlr.LogImportance.DEBUG);
    var display = new Wl.Display();
    state = new State() {
        display = display
    };
    
    var backend = new Wlr.Backend(display.get_event_loop());
    if (backend == null) {
        print("Failed to create backend\n");
        return;
    }
    Wlr.log(Wlr.LogImportance.INFO, "Backend created");
    
    var renderer = new Wlr.Renderer(backend);
    Wlr.log(Wlr.LogImportance.INFO, "Renderer created");
    var allocator = new Wlr.Allocator(backend, state.renderer);
    Wlr.log(Wlr.LogImportance.INFO, "Allocator created");
    
    Wlr.log(Wlr.LogImportance.INFO, "Adding signals");
    backend.new_output.add(state.new_output);
    state.new_output.notify = new_output;
    
    backend.new_input.add(state.new_input);
    state.new_input.notify = new_input;
    
    Wlr.log(Wlr.LogImportance.INFO, "Signals added");
    
    if (!backend.start()) {
        print("backend failed to start\n");
        return;
    }
    
    print("Started\n");
    
    display.run();
}