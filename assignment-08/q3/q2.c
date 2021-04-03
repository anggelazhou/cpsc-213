int q2 (int a0, int a1, int a2) {
    int ret = 0; 
    
    switch (a0) {
    case 10:  ret = a1 + a2; break;
    case 12:  ret = a1 - a2; break;
    case 14:  ret = a1 > a2 ? 1 : 0; break;
    case 16:  ret = a2 > a1 ? 1 : 0; break;
    case 18:  ret = a1 == a2 ? 1 : 0; break;
    default:  ret = 0;
  }

  return ret;
}