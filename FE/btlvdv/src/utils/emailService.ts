import emailjs from 'emailjs-com';

interface EmailParams {
  to_name: string;
  to_email: string;
  from_name: string;
  message: string;
  reply_to: string;
  order_id?: string;
  order_status?: string;
  order_total?: string;
}

const EMAIL_CONFIG = {
  SERVICE_ID: 'service_sijsp3j',
  TEMPLATE_ID: 'template_0scx1lo',
  PUBLIC_KEY: 'E78NkKZWgxTRU6TfH'
};

export const sendOrderStatusEmail = async (params: EmailParams) => {
  try {
    const result = await emailjs.send(
      EMAIL_CONFIG.SERVICE_ID,
      EMAIL_CONFIG.TEMPLATE_ID,
      {
        to_name: params.to_name,
        to_email: params.to_email,
        from_name: params.from_name,
        message: params.message,
        reply_to: params.reply_to,
        order_id: params.order_id,
        order_status: params.order_status,
        order_total: params.order_total
      },
      EMAIL_CONFIG.PUBLIC_KEY
    );
    
    console.log('Email sent successfully:', result.text);
    return { success: true, message: 'Email sent successfully' };
  } catch (error) {
    console.error('Error sending email:', error);
    return { success: false, message: 'Failed to send email' };
  }
};


export const sendOrderConfirmationEmail = async (params: EmailParams) => {
  try {
    const result = await emailjs.send(
      EMAIL_CONFIG.SERVICE_ID,
      'YOUR_ORDER_CONFIRMATION_TEMPLATE_ID', // Template khác cho xác nhận đơn hàng
      {
        to_name: params.to_name,
        to_email: params.to_email,
        from_name: params.from_name,
        message: params.message,
        reply_to: params.reply_to,
        order_id: params.order_id,
        order_status: params.order_status,
        order_total: params.order_total
      },
      EMAIL_CONFIG.PUBLIC_KEY
    );
    
    console.log('Order confirmation email sent successfully:', result.text);
    return { success: true, message: 'Order confirmation email sent successfully' };
  } catch (error) {
    console.error('Error sending order confirmation email:', error);
    return { success: false, message: 'Failed to send order confirmation email' };
  }
};

export const sendOrderCancellationEmail = async (params: EmailParams) => {
  try {
    const result = await emailjs.send(
      EMAIL_CONFIG.SERVICE_ID,
      'YOUR_ORDER_CANCELLATION_TEMPLATE_ID', // Template khác cho hủy đơn hàng
      {
        to_name: params.to_name,
        to_email: params.to_email,
        from_name: params.from_name,
        message: params.message,
        reply_to: params.reply_to,
        order_id: params.order_id,
        order_status: params.order_status,
        order_total: params.order_total
      },
      EMAIL_CONFIG.PUBLIC_KEY
    );
    
    console.log('Order cancellation email sent successfully:', result.text);
    return { success: true, message: 'Order cancellation email sent successfully' };
  } catch (error) {
    console.error('Error sending order cancellation email:', error);
    return { success: false, message: 'Failed to send order cancellation email' };
  }
}; 