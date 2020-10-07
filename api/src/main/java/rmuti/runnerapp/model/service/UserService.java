package rmuti.runnerapp.model.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import rmuti.runnerapp.model.beans.LoginBean;
import rmuti.runnerapp.model.table.UserProfile;
import rmuti.runnerapp.oauth2.TokenService;
import rmuti.runnerapp.util.EncoderUtil;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Component
public class UserService {

    @Autowired
    private UserProfileRepository userProfileRepository;

    @Autowired
    private EncoderUtil encoderUtil;

    @Autowired
    private TokenService tokenService;

    public Optional<Map<String, Object>> login(LoginBean loginBean) {
        UserProfile userProfile = userProfileRepository.findByUserName(loginBean.getUsername());
        if (userProfile != null) {
            String userPassWord = userProfile.getPassWord();
            if (encoderUtil.passwordEncoder().matches(loginBean.getPassword(), userPassWord)) {
                Map<String, Object> ret = new HashMap<>();
                ret.put("token", tokenService.createToken(userProfile));
                ret.put("userId", userProfile.getUserId());
                return Optional.of(ret);
            } else {
                return Optional.empty();
            }
        }
        return Optional.empty();
    }
}