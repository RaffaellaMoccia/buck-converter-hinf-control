function CL = build_CL_DR(Pss_k, K, kFF, E_block, F_block)
% BUILD_CL_DR  Costruisce l'anello chiuso del Buck converter con
%              un eventuale schema di disturbance rejection.
%   CL = build_CL_DR(Pss_k, K, kFF, E_block, F_block)
%
%   Pss_k    : Power Stage (InputName {'vSW','iout_tilde'}, OutputName {'vo','iL'})
%   K        : controllore K(s) (H-infinity, K_connect)
%   kFF      : guadagno feed-forward del PWM
%   E_block  : blocco estimator (E_DOB, E_UIO, E_LEC) — passa [] per "No DR"
%   F_block  : blocco filtro di compensazione (F_DOB, F_filter) — passa [] per "No DR"
%
%   Restituisce un sistema con ingressi {'r','iout_tilde'} e
%   uscite {'vo','iL','vc_tot'}.

    K_named = K;
    K_named.InputName  = 'e';
    K_named.OutputName = 'vc';

    Sum_e = sumblk('e = r - vo');

    if isempty(E_block)
        % --- Nessuno schema DR: vc_tot = vc ---
        Sum_pre = sumblk('vc_tot = vc');
        kFF_blk = tf(kFF,1);
        kFF_blk.InputName  = 'vc_tot';
        kFF_blk.OutputName = 'vSW';

        CL = connect(Pss_k, K_named, kFF_blk, Sum_e, Sum_pre, ...
            {'r','iout_tilde'}, {'vo','iL','vc_tot'});
    else
        % --- Con schema DR: vc_tot = vc + vinj ---
        E_named = E_block;
        E_named.OutputName = 'ihat';

        F_named = F_block;
        F_named.InputName  = 'ihat';
        F_named.OutputName = 'vinj';

        Sum_pre = sumblk('vc_tot = vc + vinj');
        kFF_blk = tf(kFF,1);
        kFF_blk.InputName  = 'vc_tot';
        kFF_blk.OutputName = 'vSW';

        CL = connect(Pss_k, K_named, E_named, F_named, kFF_blk, Sum_e, Sum_pre, ...
            {'r','iout_tilde'}, {'vo','iL','vc_tot'});
    end
end
