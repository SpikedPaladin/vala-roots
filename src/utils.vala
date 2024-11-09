public class Utils {
    public static unowned T get_listener_parent<T> (ref Wl.Listener listener, int offset) {
        return (T*)((size_t)&listener - offset);
    }
}