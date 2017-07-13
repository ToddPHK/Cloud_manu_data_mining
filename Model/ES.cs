namespace Model
{
    public class sumAverageArray
    {
        public static double AverageArray(double[] arr)
        {
            double sum = 0;
            double average = 0;
            int size = arr.Length;
            for (int i = 0; i < size; i++)
            {
                sum += arr[i];
            }

            average = sum / size; // sum divided by total elements in array

            return average;
        }
    }

public class ES
{
    private int length = 0;         //原始数据的个数
    private int Extension = 0;              //待预测的数据个数
    private double[] values = null;      //原始数据
    private double[] X = null;              //预测的结果
    private double[] X2 = null;
    private double[] Y = null;
    private double Alpha = 0;

    public ES(double[] value, int num, double Alph)
    {
        Alpha = Alph;
        Extension = num;
        length = value.GetLength(0);
        values = new double[length];// 分配内存
        values = value;

    }

    public double[] ES_FirResult()
    {
        X = new double[length + Extension];
        double[] slip = new double[length + 1];
        slip[0] = 0.0;
        for (int i = 1; i < (length + Extension); i++)
        {
            if (length > 20)
            {
                X[0] = values[0];
            }
            else
            {
                X[0] = (values[0] + values[1]) / 2.0;
            }
            if (i <= values.Length)
            {//test set
                slip[i] = values[i - 1] - X[i - 1];
                double PriorForecast = X[i - 1];
                double PriorValue = values[i - 1];

                X[i] = Alpha * PriorValue + (1 - Alpha) * PriorForecast + slip[i];
            }
            else
            {//extension has to use prior forecast instead of prior value
                double PriorForecast = X[i - 1];
                double PriorValue = X[i - 1];
                double avgSlip = sumAverageArray.AverageArray(slip);
                X[i] = Alpha * PriorValue + (1 - Alpha) * PriorForecast + avgSlip;
            }
        }
        return X;
    }


    public double[] ES_SecResult()
    {
        X = new double[length + Extension];
        X2 = new double[length + Extension];
        double[] slip = new double[length + 1];
        slip[0] = 0.0;
        for (int i = 1; i < (length + Extension); i++)
        {
            if (length > 20)
            {
                X[0] =X2[0]= values[0];
            }
            else
            {
                X[0] = X2[0] = (values[0] + values[1]) / 2.0;
            }
            if (i <= values.Length)
            {//test set
                slip[i] = values[i - 1] - X2[i - 1];
                double PriorForecast = X[i - 1];
                double PriorValue = values[i - 1];
                X[i] = Alpha * PriorValue + (1 - Alpha) * PriorForecast + slip[i];
                X2[i] = Alpha * X[i] + (1 - Alpha) * X2[i - 1];
            }
            else
            {//extension has to use prior forecast instead of prior value

                double PriorForecast = X[i - 1];
                double PriorValue = X[i - 1];
                double avgSlip = sumAverageArray.AverageArray(slip);
                X[i] = Alpha * PriorValue + (1 - Alpha) * PriorForecast+avgSlip ;
                X2[i] = Alpha * X[i] + (1 - Alpha) * X2[i - 1];
            }
        }
        return X2;
    }
}
}