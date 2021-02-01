package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "save_runner")
public class SaveRunner {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column
    private double lat;
    @Column
    private double lng;
    @Column(name = "user_id")
    private int userId;
}
