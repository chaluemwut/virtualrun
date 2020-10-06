package rmuti.runnerapp.model.service;

import org.springframework.data.jpa.repository.JpaRepository;
import rmuti.runnerapp.model.table.Mini;

public interface MiniRepository extends JpaRepository<Mini,Integer> {
}
