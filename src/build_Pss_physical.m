function Pss_k = build_Pss_physical(Lk, Ck, Rik, RONk, Rck, RLk)
% BUILD_PSS_PHYSICAL  Realizzazione di stato fisica del Power Stage
%   Pss_k = build_Pss_physical(Lk, Ck, Rik, RONk, Rck, RLk)
%
%   Costruisce la realizzazione di stato a 2 stati del Power Stage del
%   Buck converter (Lena, Setti, Pareschi et al., arXiv:2509.02102v1),
%   a partire dai valori dei componenti fisici passati come argomenti.
%   Ingressi del sistema:  {'vSW','iout_tilde'}
%   Uscite del sistema:    {'vo','iL'}

    Ri_pk = Rik + RONk;
    Rsumk = RLk + Rck;

    Apk = [ -(Ri_pk + RLk*Rck/Rsumk)/Lk,  -RLk/(Lk*Rsumk);
             RLk/(Ck*Rsumk),              -1/(Ck*Rsumk) ];

    Bpk = [ 1/Lk,                    RLk*Rck/(Lk*Rsumk);
            0,                      -RLk/(Ck*Rsumk) ];

    Cpk = [ Rck*RLk/Rsumk,  RLk/Rsumk;
            1,              0 ];

    Dpk = [ 0,   -Rck*RLk/Rsumk;
            0,    0 ];

    Pss_k = ss(Apk, Bpk, Cpk, Dpk);
    Pss_k.InputName  = {'vSW','iout_tilde'};
    Pss_k.OutputName = {'vo','iL'};
end
