package rmuti.runnerapp.controller;

import lombok.Data;
import lombok.ToString;

@ToString
@Data
public class APIResponse {
    private int status;
    private String message;
    private Object data;
    private int getId;
    private Object getData;
}
