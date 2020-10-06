package rmuti.runnerapp.model.table;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity(name = "fun_run")
public class FunRun {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "f_id")
    private int Fid;
    @Column(name = "time")
    private String Time;
    @Column(name = "km")
    private String Km;
}
